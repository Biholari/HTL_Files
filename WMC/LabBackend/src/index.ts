import express from "express";
import { DataSource } from "typeorm";
import cors from "cors";
import { Order } from "./entities/Order";
import { User } from "./entities/User";
import { Product } from "./entities/Product";
import orderRoutes from "./routes/orderRoutes";
import authRoutes from "./routes/authRoutes";
import productRoutes from "./routes/productRoutes";
import { Rating } from "./entities/Rating";
import axios from "axios";

async function seedDatabaseFromAPI() {
    try {
        const response = await axios.get("https://fakestoreapi.com/products");
        const products = response.data;

        const productRepo = AppDataSource.getRepository(Product);
        const ratingRepo = AppDataSource.getRepository(Rating);

        for (const item of products) {
            let savedRating: Rating | null = null;

            // Try to create and save rating
            try {
                const rating = ratingRepo.create({
                    rate: item.rating.rate,
                    count: item.rating.count,
                });
                savedRating = await ratingRepo.save(rating);
            } catch (error) {
                console.error(
                    `Error creating rating for ${item.title}:`,
                    error
                );
                savedRating = item.rating;
                continue;
            }

            // Try to create and save product
            try {
                const product = productRepo.create({
                    title: item.title,
                    price: item.price,
                    description: item.description,
                    category: item.category,
                    image: item.image,
                    rating: savedRating as Rating,
                });
                await productRepo.save(product);
            } catch (error) {
                console.error(`Error creating product ${item.title}:`, error);
            }
        }

        console.log("Database seeded with Fake Store API data");
    } catch (error) {
        console.error("Error fetching data from API:", error);
    }
}

const app = express();
const port = 3333;

app.use(cors());

export const AppDataSource = new DataSource({
    type: "mysql",
    host: "localhost",
    port: 3307,
    username: "root",
    password: "root",
    database: "shop_db",
    entities: [Order, User, Product, Rating],
    synchronize: true,
});

AppDataSource.initialize()
    .then(async () => {
        console.info("Datenbank verbunden");
        // await seedDatabaseFromAPI();
    })
    .catch((error) => console.error("Fehler beim Verbinden der DB:", error));

// Routen
app.use("/orders", orderRoutes);
app.use("/auth", authRoutes);
app.use("/products", productRoutes);

app.listen(port, () => {
    console.info(`Server läuft auf http://localhost:${port}`);
});

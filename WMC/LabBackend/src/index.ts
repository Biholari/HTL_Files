import express from "express";
import { DataSource } from "typeorm";
import cors from "cors";
import orderRoutes from "./routes/orderRoutes";
import authRoutes from "./routes/authRoutes";
import productRoutes from "./routes/productRoutes";
import axios from "axios";
import { Product } from "./entities/Product";
import { Rating } from "./entities/Rating";

const app = express();
const port = 3333;

app.use(cors());

async function seedDatabaseFromAPI() {
    const response = await axios.get("https://fakestoreapi.com/products");
    const products = response.data;
    let productRepository = AppDataSource.getRepository(Product);
    let ratingRepository = AppDataSource.getRepository(Rating);

    const ratings = new Set<{ rate: number; count: number }>();

    for (const product of products) {
        let savedRating = null;
        if (!ratings.has(product.rating)) {
            savedRating = await ratingRepository.save(product.rating);
            ratings.add(product.rating);
        }

        const newProduct = new Product();

        Object.assign(newProduct, product);

        if (savedRating) {
            newProduct.rating = savedRating;
        }

        await productRepository.save(newProduct);
    }
}

export const AppDataSource = new DataSource({
    type: "mysql",
    host: "localhost",
    port: 3307,
    username: "root",
    password: "root",
    database: "shop_db",
    entities: ["src/entities/**/*.ts"],
    synchronize: true,
});

AppDataSource.initialize()
    .then(async () => {
        console.info("Datenbank verbunden");
        await seedDatabaseFromAPI();
    })
    .catch((error) => console.error("Fehler beim Verbinden der DB:", error));

// Routen
app.use("/orders", orderRoutes);
app.use("/auth", authRoutes);
app.use("/products", productRoutes);

app.listen(port, () => {
    console.info(`Server läuft auf http://localhost:${port}`);
});

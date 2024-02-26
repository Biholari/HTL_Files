import express from "express";
import { Product } from "../entity/Products";

const router = express.Router();

let products: Product[] = [
    {
        id: 1,
        name: "Product 1",
        description: "This is product 1",
        price: 100,
    },
    {
        id: 2,
        name: "Product 2",
        description: "This is product 2",
        price: 200,
    },
];

router.get("/", (req, res) => {
    res.status(200).json({ products });
});

/*
GET /
GET /:pid			(hole Produkt mit ID = :pid)
POST /			    (füge neues Produkt in DB hinzu)
UPDATE /:pid		(ändere Produkt mit ID = :pid)
DELETE /:pid		(lösche Produkt mit ID = :pid)
*/

router.get("/:pid", (req, res) => {
    const pid = parseInt(req.params.pid);
    const product = products.find((p) => p.id === pid);
    if (product) {
        res.status(200).json({ product });
    } else {
        res.status(404).json({ message: "Product not found" });
    }
});

router.post("/", (req, res) => {
    // Create own simple product with random things
    let product: Product = {
        id: Math.floor(Math.random() * 1000),
        name: "Product " + Math.floor(Math.random() * 1000),
        description: "This is product " + Math.floor(Math.random() * 1000),
        price: Math.floor(Math.random() * 1000),
    };

    products.push(product);

    res.status(201).json({ message: "Product created" });
});

router.put("/:pid", (req, res) => {
    const pid = parseInt(req.params.pid);
    let product: Product = {
        id: Math.floor(Math.random() * 1000),
        name: "Product " + Math.floor(Math.random() * 1000),
        description: "This is product " + Math.floor(Math.random() * 1000),
        price: Math.floor(Math.random() * 1000),
    };
    const index = products.findIndex((p) => p.id === pid);
    if (index >= 0) {
        products[index] = product;
        res.status(200).json({ message: "Product updated" });
    } else {
        res.status(404).json({ message: "Product not found" });
    }
});

router.delete("/:pid", (req, res) => {
    const pid = parseInt(req.params.pid);
    const index = products.findIndex((p) => p.id === pid);
    if (index >= 0) {
        products.splice(index, 1);
        res.status(200).json({ message: "Product deleted" });
    } else {
        res.status(404).json({ message: "Product not found" });
    }
});

export default router;

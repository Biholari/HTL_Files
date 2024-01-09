import express from 'express';
import { Product } from '../entity/Products';

const router = express.Router();

let products: Product[] = [
    {
        id: 1,
        name: 'Product 1',
        description: 'This is product 1',
        price: 100,
    },
    {
        id: 2,
        name: 'Product 2',
        description: 'This is product 2',
        price: 200,
    },
];

router.get("/", (req, res) => {
    res.status(200).json({products});
});

export default router;
import { Router } from "express";
import { Order } from "../entities/Order";
import { AppDataSource } from "..";

const router = Router();

router.post("/", async (req, res) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const newOrder = orderRepo.create(req.body);
    const savedOrder = await orderRepo.save(newOrder);
    res.status(201).json(savedOrder);
});

router.get("/", async (req, res) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const orders = await orderRepo.find({ relations: ["products"] });
    res.json(orders);
});

router.get("/:id", async (req, res) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const order = await orderRepo.findOneBy({ id: parseInt(req.params.id) });
    if (order) {
        res.json(order);
    } else {
        res.status(404).json({ message: "Order not found" });
    }
});

router.put("/:id/complete", async (req, res) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const order = await orderRepo.findOneBy({ id: parseInt(req.params.id) });
    if (order) {
        order.status = "completed";
        await orderRepo.save(order);
        res.json(order);
    } else {
        res.status(404).json({ message: "Order not found" });
    }
});

router.put("/:id/cancel", async (req, res) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const order = await orderRepo.findOneBy({ id: parseInt(req.params.id) });
    if (order) {
        order.status = "canceled";
        await orderRepo.save(order);
        res.json(order);
    } else {
        res.status(404).json({ message: "Order not found" });
    }
});

export default router;

import { Router } from "express";
import { Order } from "../entities/Order";
import { AppDataSource } from "..";
import { OrderItem } from "../entities/OrderItem";

const router = Router();

router.post("/", async (req, res) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const newOrder = orderRepo.create(req.body);
    const savedOrder = await orderRepo.save(newOrder);
    res.status(201).json(savedOrder);
});

router.post("/:id/items", async (req, res: any) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const itemRepo = AppDataSource.getRepository(OrderItem);

    const order = await orderRepo.findOneBy({ id: parseInt(req.params.id) });
    if (!order) {
        return res.status(404).json({ message: "Order not found" });
    }

    const newItem = itemRepo.create({
        ...req.body,
        orderId: order.id,
    });

    const savedItem = await itemRepo.save(newItem);
    res.status(201).json(savedItem);
});

router.get("/", async (req, res) => {
    const orderRepo = AppDataSource.getRepository(Order);
    const orders = await orderRepo.find({
        relations: ["customer", "items", "items.product"],
    });
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
        order.status = "COMPLETED"; // Changed from "completed"
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
        order.status = "CANCELLED"; // Changed from "canceled"
        await orderRepo.save(order);
        res.json(order);
    } else {
        res.status(404).json({ message: "Order not found" });
    }
});

export default router;

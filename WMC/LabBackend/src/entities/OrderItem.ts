import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    ManyToOne,
    JoinColumn,
} from "typeorm";
import { Product } from "./Product";
import { Order } from "./Order";

@Entity("orderItems")
export class OrderItem {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column()
    quantity!: number;

    @Column("decimal", { precision: 10, scale: 2 })
    price!: number;

    // Relations
    @ManyToOne(() => Order, (order) => order.items)
    @JoinColumn({ name: "orderId" })
    order!: Order;

    @Column()
    orderId!: number;

    @ManyToOne(() => Product, (product) => product.orderItems)
    @JoinColumn({ name: "productId" })
    product!: Product;

    @Column()
    productId!: number;
}

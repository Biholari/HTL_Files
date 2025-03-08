import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    JoinColumn,
    OneToMany,
    CreateDateColumn,
    ManyToOne,
    JoinTable,
} from "typeorm";
import { Customer } from "./Customer";
import { OrderItem } from "./OrderItem";

@Entity("orders")
export class Order {
    @PrimaryGeneratedColumn()
    id!: number;

    @CreateDateColumn()
    orderDate!: Date;

    @Column("decimal", { precision: 10, scale: 2 })
    totalAmount!: number;

    @Column({
        type: "enum",
        enum: ["PENDING", "COMPLETED", "CANCELLED"],
        default: "PENDING",
    })
    status!: "PENDING" | "COMPLETED" | "CANCELLED";

    @ManyToOne(() => Customer, (customer) => customer.orders)
    customer!: Customer;

    @OneToMany(() => OrderItem, (orderItem) => orderItem.order, {
        cascade: true,
    })
    items!: OrderItem[];
}

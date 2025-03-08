import {
    Column,
    Entity,
    JoinColumn,
    JoinTable,
    OneToMany,
    OneToOne,
    PrimaryGeneratedColumn,
} from "typeorm";
import { OrderItem } from "./OrderItem";
import { Rating } from "./Rating";

@Entity("products")
export class Product {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column()
    title!: string;

    @Column("decimal", { precision: 10, scale: 2 })
    price!: number;

    @Column("text")
    description!: string;

    @Column()
    category!: string;

    @Column()
    image!: string;

    @OneToOne(() => Rating)
    @JoinColumn([
        { name: "rating_rate", referencedColumnName: "rate" },
        { name: "rating_count", referencedColumnName: "count" },
    ])
    rating!: Rating;

    // Relations
    @OneToMany(() => OrderItem, (orderItem) => orderItem.product)
    orderItems!: OrderItem[];
}

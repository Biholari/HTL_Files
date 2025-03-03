import {
    Column,
    Entity,
    JoinColumn,
    OneToOne,
    PrimaryGeneratedColumn,
} from "typeorm";
import { Rating } from "./Rating";

@Entity()
export class Product {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column()
    title!: string;

    @Column("decimal")
    price!: number;

    @Column("text")
    description!: string;

    @Column()
    category!: string;

    @Column()
    image!: string;

    @OneToOne(() => Rating)
    @JoinColumn()
    rating!: Rating;
}

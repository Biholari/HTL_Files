import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    ManyToMany,
    JoinTable,
} from "typeorm";
import { Product } from "./Product";

@Entity()
export class Order {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column()
    firstName!: string;

    @Column()
    lastName!: string;

    @Column()
    street!: string;

    @Column()
    postalCode!: string;

    @Column()
    city!: string;

    @Column({ default: "open" })
    status!: string;

    @ManyToMany(() => Product)
    @JoinTable()
    products!: Product[];
}

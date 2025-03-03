import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Product } from "./Product";

@Entity()
export class Rating {
    @PrimaryGeneratedColumn()
    rate!: number;

    @Column()
    count!: number;
}

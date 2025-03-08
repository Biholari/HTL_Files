import { Column, Entity, OneToMany, PrimaryColumn } from "typeorm";
import { Order } from "./Order";

@Entity()
export class Customer {
    @Column()
    salutation!: string;

    @PrimaryColumn()
    firstName!: string;

    @PrimaryColumn()
    lastName!: string;

    @Column()
    street!: string;

    @Column()
    zip!: string;

    @Column()
    city!: string;

    @OneToMany(() => Order, (order) => order.customer)
    orders!: Order[];
}

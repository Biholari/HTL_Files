import { Entity, PrimaryColumn, Unique } from "typeorm";

@Unique(["rate", "count"])
@Entity()
export class Rating {
    @PrimaryColumn("decimal", { precision: 3, scale: 1 })
    rate!: number;

    @PrimaryColumn({ unique: true })
    count!: number;
}

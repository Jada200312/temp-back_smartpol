import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  CreateDateColumn,
  UpdateDateColumn,
  Unique,
} from 'typeorm';
import { Department } from './department.entity';

@Entity('municipalities')
@Unique(['name', 'departmentId'])
export class Municipality {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  code: string;

  @ManyToOne(() => Department, (department) => department.municipalities, {
    onDelete: 'CASCADE',
  })
  department: Department;

  @Column()
  departmentId: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}

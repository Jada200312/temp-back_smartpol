import { Entity, PrimaryGeneratedColumn, Column, ManyToMany, ManyToOne, JoinColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Candidate } from './candidate.entity';
import { Department } from './department.entity';
import { Municipality } from './municipality.entity';

@Entity('voters')
export class Voter {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  firstName: string;

  @Column()
  lastName: string;

  @Column({ unique: true })
  identification: string;

  @Column()
  gender: string;

  @Column()
  bloodType: string;

  @Column({ type: 'date' })
  birthDate: Date;

  @Column()
  phone: string;

  @Column()
  address: string;

  @Column({ nullable: true })
  departmentId: number;

  @ManyToOne(() => Department)
  @JoinColumn({ name: 'departmentId' })
  department: Department;

  @Column({ nullable: true })
  municipalityId: number;

  @ManyToOne(() => Municipality)
  @JoinColumn({ name: 'municipalityId' })
  municipality: Municipality;

  @Column()
  neighborhood: string;

  @Column({ unique: true })
  email: string;

  @Column()
  occupation: string;

  @Column()
  votingLocation: string;

  @Column()
  votingBooth: string;

  @Column()
  politicalStatus: string;

  @ManyToMany(() => Candidate, (candidate) => candidate.voters)
  candidates: Candidate[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
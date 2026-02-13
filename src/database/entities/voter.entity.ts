import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToMany,
  ManyToOne,
  JoinColumn,
  JoinTable,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
} from 'typeorm';
import { Candidate } from './candidate.entity';
import { Leader } from './leader.entity';
import { Department } from './department.entity';
import { Municipality } from './municipality.entity';
import { VotingBooth } from './voting-booth.entity';

@Entity('voters')
@Index(['identification'])
@Index(['departmentId'])
@Index(['municipalityId'])
@Index(['votingBoothId'])
@Index(['firstName', 'lastName'])
@Index(['email'])
@Index(['phone'])
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

  @ManyToOne(() => Department, { nullable: true })
  @JoinColumn({ name: 'departmentId' })
  department: Department;

  @Column({ nullable: true })
  municipalityId: number;

  @ManyToOne(() => Municipality, { nullable: true })
  @JoinColumn({ name: 'municipalityId' })
  municipality: Municipality;

  @Column({ nullable: true })
  neighborhood: string;

  @Column({ nullable: true })
  email: string;

  @Column({ nullable: true })
  occupation: string;

  @Column({ nullable: true })
  votingBoothId: number;

  @ManyToOne(() => VotingBooth, { nullable: true })
  @JoinColumn({ name: 'votingBoothId' })
  votingBooth: VotingBooth;

  @Column({ nullable: true })
  votingTableId: string;

  @Column({ nullable: true })
  politicalStatus: string;

  @ManyToMany(() => Candidate, (candidate) => candidate.voters)
  @JoinTable({
    name: 'candidate_voters',
    joinColumn: { name: 'voterId', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'candidateId', referencedColumnName: 'id' },
  })
  candidates: Candidate[];

  @CreateDateColumn()
  createdAt: Date;

  leaders?: Leader[] | null;

  @UpdateDateColumn()
  updatedAt: Date;
}

import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  OneToMany,
  JoinColumn,
  Unique,
} from 'typeorm';
import { Municipality } from './municipality.entity';
import { VotingTable } from './voting-table.entity';

@Entity('voting_booths')
@Unique(['code', 'municipalityId'])
export class VotingBooth {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ unique: true, nullable: true }) // ✅ AGREGADO nullable: true
  code: string;

  @ManyToOne(() => Municipality, {
    onDelete: 'CASCADE',
    nullable: false,
  })
  @JoinColumn({ name: 'municipalityId' })
  municipality: Municipality;

  @Column()
  municipalityId: number;

  @OneToMany(() => VotingTable, (votingTable) => votingTable.votingBooth, {
    cascade: ['remove'],
  })
  votingTables: VotingTable[];
}
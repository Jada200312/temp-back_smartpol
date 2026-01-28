import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, ManyToMany, JoinColumn, JoinTable, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Corporation } from './corporation.entity';
import { Leader } from './leader.entity';
import { Voter } from './voter.entity';

@Entity('candidates')
export class Candidate {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  party: string;

  @Column()
  number: number;

  @ManyToOne(() => Corporation, (corporation) => corporation.candidates)
  @JoinColumn({ name: 'corporation_id' })
  corporation: Corporation;

  @Column()
  corporation_id: number;

  @ManyToMany(() => Leader, (leader) => leader.candidates, { cascade: true })
  @JoinTable({
    name: 'candidate_leader',
    joinColumn: { name: 'candidate_id', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'leader_id', referencedColumnName: 'id' },
  })
  leaders: Leader[];

  @ManyToMany(() => Voter, (voter) => voter.candidates, { cascade: true })
  @JoinTable({
    name: 'candidate_voter',
    joinColumn: { name: 'candidate_id', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'voter_id', referencedColumnName: 'id' },
  })
  voters: Voter[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}


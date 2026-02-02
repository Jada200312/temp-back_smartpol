import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Voter } from '../../database/entities/voter.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { Leader } from '../../database/entities/leader.entity';
import { CandidateVoter } from '../../database/entities/candidate-voter.entity';
import { Department } from '../../database/entities/department.entity';
import { Municipality } from '../../database/entities/municipality.entity';
import { VoterService } from './voter.service';
import { VoterController } from './voter.controller';
import { VotingBooth } from 'src/database/entities/voting-booth.entity';
import { VotingTable } from 'src/database/entities/voting-table.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Voter,
      Candidate,
      Leader,
      CandidateVoter,
      Department,
      Municipality,
      VotingBooth,
      VotingTable,
    ]),
  ],
  controllers: [VoterController],
  providers: [VoterService],
  exports: [VoterService],
})
export class VoterModule {}

import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Leader } from '../../database/entities/leader.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { User } from '../../database/entities/user.entity';
import { LeaderService } from './leader.service';
import { LeaderController } from './leader.controller';
import { Campaign } from 'src/database/entities';

@Module({
  imports: [TypeOrmModule.forFeature([Leader, Candidate, User, Campaign])],
  controllers: [LeaderController],
  providers: [LeaderService],
  exports: [LeaderService],
})
export class LeaderModule {}

import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Leader } from '../../database/entities/leader.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { LeaderService } from './leader.service';
import { LeaderController } from './leader.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Leader, Candidate])],
  controllers: [LeaderController],
  providers: [LeaderService],
  exports: [LeaderService],
})
export class LeaderModule {}

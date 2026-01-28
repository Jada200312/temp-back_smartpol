import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Voter } from '../../database/entities/voter.entity';
import { Department } from '../../database/entities/department.entity';
import { Municipality } from '../../database/entities/municipality.entity';
import { VoterService } from './voter.service';
import { VoterController } from './voter.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Voter, Department, Municipality])],
  controllers: [VoterController],
  providers: [VoterService],
  exports: [VoterService],
})
export class VoterModule {}

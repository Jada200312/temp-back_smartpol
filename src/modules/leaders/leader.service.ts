import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Leader } from '../../database/entities/leader.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { CreateLeaderDto } from './dto/create-leader.dto';
import { UpdateLeaderDto } from './dto/update-leader.dto';

@Injectable()
export class LeaderService {
  constructor(
    @InjectRepository(Leader)
    private readonly leaderRepository: Repository<Leader>,
    @InjectRepository(Candidate)
    private readonly candidateRepository: Repository<Candidate>,
  ) {}

  async create(createLeaderDto: CreateLeaderDto): Promise<Leader> {
    const leader = this.leaderRepository.create(createLeaderDto);
    return await this.leaderRepository.save(leader);
  }

  async findAll(): Promise<Leader[]> {
    return await this.leaderRepository.find();
  }

  async findOne(id: number): Promise<Leader | null> {
    return await this.leaderRepository.findOneBy({ id });
  }

  async update(id: number, updateLeaderDto: UpdateLeaderDto): Promise<Leader | null> {
    await this.leaderRepository.update(id, updateLeaderDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.leaderRepository.delete(id);
  }

  async getCandidates(leaderId: number): Promise<Candidate[]> {
    const leader = await this.leaderRepository.findOne({
      where: { id: leaderId },
      relations: ['candidates'],
    });

    if (!leader) {
      return [];
    }

    return leader.candidates;
  }
}

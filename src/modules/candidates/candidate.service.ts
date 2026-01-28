import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Candidate } from '../../database/entities/candidate.entity';
import { Leader } from '../../database/entities/leader.entity';
import { CreateCandidateDto } from './dto/create-candidate.dto';
import { UpdateCandidateDto } from './dto/update-candidate.dto';

@Injectable()
export class CandidateService {
  constructor(
    @InjectRepository(Candidate)
    private readonly candidateRepository: Repository<Candidate>,
    @InjectRepository(Leader)
    private readonly leaderRepository: Repository<Leader>,
  ) {}

  async create(createCandidateDto: CreateCandidateDto): Promise<Candidate> {
    const candidate = this.candidateRepository.create(createCandidateDto);
    return await this.candidateRepository.save(candidate);
  }

  async findAll(): Promise<Candidate[]> {
    return await this.candidateRepository.find({ relations: ['corporation'] });
  }

  async findOne(id: number): Promise<Candidate | null> {
    return await this.candidateRepository.findOne({
      where: { id },
      relations: ['corporation', 'leaders'],
    });
  }

  async update(id: number, updateCandidateDto: UpdateCandidateDto): Promise<Candidate | null> {
    await this.candidateRepository.update(id, updateCandidateDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.candidateRepository.delete(id);
  }

  async assignLeaderToCandidate(candidateId: number, leaderId: number): Promise<Candidate> {
    const candidate = await this.candidateRepository.findOne({
      where: { id: candidateId },
      relations: ['leaders'],
    });

    if (!candidate) {
      throw new NotFoundException(`Candidate with ID ${candidateId} not found`);
    }

    const leader = await this.leaderRepository.findOne({
      where: { id: leaderId },
    });

    if (!leader) {
      throw new NotFoundException(`Leader with ID ${leaderId} not found`);
    }

    // Avoid duplicates
    if (!candidate.leaders.some((l) => l.id === leaderId)) {
      candidate.leaders.push(leader);
      await this.candidateRepository.save(candidate);
    }

    return candidate;
  }

  async removeLeaderFromCandidate(candidateId: number, leaderId: number): Promise<Candidate> {
    const candidate = await this.candidateRepository.findOne({
      where: { id: candidateId },
      relations: ['leaders'],
    });

    if (!candidate) {
      throw new NotFoundException(`Candidate with ID ${candidateId} not found`);
    }

    candidate.leaders = candidate.leaders.filter((l) => l.id !== leaderId);
    await this.candidateRepository.save(candidate);

    return candidate;
  }

  async getLeadersByCandidate(candidateId: number): Promise<Leader[]> {
    const candidate = await this.candidateRepository.findOne({
      where: { id: candidateId },
      relations: ['leaders'],
    });

    if (!candidate) {
      throw new NotFoundException(`Candidate with ID ${candidateId} not found`);
    }

    return candidate.leaders;
  }
}

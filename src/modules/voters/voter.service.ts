import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Voter } from '../../database/entities/voter.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { CreateVoterDto } from './dto/create-voter.dto';
import { UpdateVoterDto } from './dto/update-voter.dto';

@Injectable()
export class VoterService {
  constructor(
    @InjectRepository(Voter)
    private readonly voterRepository: Repository<Voter>,
    @InjectRepository(Candidate)
    private readonly candidateRepository: Repository<Candidate>,
  ) {}

  async create(createVoterDto: CreateVoterDto): Promise<Voter> {
    const voter = this.voterRepository.create(createVoterDto);
    return await this.voterRepository.save(voter);
  }

  async findAll(): Promise<Voter[]> {
    return await this.voterRepository.find();
  }

  async findOne(id: number): Promise<Voter | null> {
    return await this.voterRepository.findOneBy({ id });
  }

  async update(id: number, updateVoterDto: UpdateVoterDto): Promise<Voter | null> {
    await this.voterRepository.update(id, updateVoterDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.voterRepository.delete(id);
  }

  async assignCandidate(voterId: number, candidateId: number): Promise<Voter> {
    const voter = await this.voterRepository.findOne({
      where: { id: voterId },
      relations: ['candidates'],
    });

    if (!voter) {
      throw new Error(`Votante con ID ${voterId} no encontrado`);
    }

    const candidate = await this.candidateRepository.findOneBy({ id: candidateId });

    if (!candidate) {
      throw new Error(`Candidato con ID ${candidateId} no encontrado`);
    }

    voter.candidates.push(candidate);
    return await this.voterRepository.save(voter);
  }
}
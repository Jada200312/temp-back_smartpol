import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Candidate } from '../../database/entities/candidate.entity';
import { Leader } from '../../database/entities/leader.entity';
import { User } from '../../database/entities/user.entity';
import { CreateCandidateDto } from './dto/create-candidate.dto';
import { UpdateCandidateDto } from './dto/update-candidate.dto';

@Injectable()
export class CandidateService {
  constructor(
    @InjectRepository(Candidate)
    private readonly candidateRepository: Repository<Candidate>,
    @InjectRepository(Leader)
    private readonly leaderRepository: Repository<Leader>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async create(createCandidateDto: CreateCandidateDto): Promise<Candidate> {
    const candidate = this.candidateRepository.create(createCandidateDto);
    return await this.candidateRepository.save(candidate);
  }

  async findAll(): Promise<Candidate[]> {
    return await this.candidateRepository.find({ relations: ['corporation'] });
  }

  async findAllWithPagination(
    page: number = 1,
    limit: number = 10,
    search?: string,
  ): Promise<{
    data: Candidate[];
    total: number;
    page: number;
    limit: number;
    pages: number;
  }> {
    const skip = (page - 1) * limit;
    const query = this.candidateRepository
      .createQueryBuilder('candidate')
      .leftJoinAndSelect('candidate.corporation', 'corporation');

    if (search && search.trim()) {
      query
        .where('LOWER(candidate.name) LIKE LOWER(:search)', {
          search: `%${search}%`,
        })
        .orWhere('LOWER(candidate.party) LIKE LOWER(:search)', {
          search: `%${search}%`,
        })
        .orWhere('CAST(candidate.number AS CHAR) LIKE :searchNumber', {
          searchNumber: `%${search}%`,
        });
    }

    const [candidates, total] = await query
      .skip(skip)
      .take(limit)
      .getManyAndCount();

    return {
      data: candidates,
      total,
      page,
      limit,
      pages: Math.ceil(total / limit),
    };
  }

  async findOne(id: number): Promise<Candidate | null> {
    return await this.candidateRepository.findOne({
      where: { id },
      relations: ['corporation', 'leaders'],
    });
  }

  async findByUserId(userId: number): Promise<Candidate | null> {
    return await this.candidateRepository.findOne({
      where: { userId },
      relations: ['corporation', 'leaders'],
    });
  }

  async update(
    id: number,
    updateCandidateDto: UpdateCandidateDto,
  ): Promise<Candidate | null> {
    await this.candidateRepository.update(id, updateCandidateDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    // Cargar el candidato con su usuario asociado
    const candidate = await this.candidateRepository.findOne({
      where: { id },
      relations: ['leaders', 'user'],
    });

    if (candidate) {
      // Si el candidato tiene un usuario asociado, eliminarlo también
      if (candidate.userId) {
        await this.userRepository.delete(candidate.userId);
      }

      // TypeORM eliminará automáticamente las relaciones en candidate_leader
      // porque tenemos cascade: true y onDelete: 'CASCADE' configurados
      await this.candidateRepository.remove(candidate);
    }
  }

  async assignLeaderToCandidate(
    candidateId: number,
    leaderId: number,
  ): Promise<Candidate> {
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

  async removeLeaderFromCandidate(
    candidateId: number,
    leaderId: number,
  ): Promise<Candidate> {
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

  async findByLeaderAndCorporation(
    leaderId: number,
    corporationId: number,
  ): Promise<Candidate[]> {
    return await this.candidateRepository
      .createQueryBuilder('candidate')
      .innerJoinAndSelect(
        'candidate.leaders',
        'leader',
        'leader.id = :leaderId',
        { leaderId },
      )
      .innerJoinAndSelect('candidate.corporation', 'corporation')
      .where('candidate.corporation_id = :corporationId', { corporationId })
      .setParameter('leaderId', leaderId)
      .setParameter('corporationId', corporationId)
      .getMany();
  }
}

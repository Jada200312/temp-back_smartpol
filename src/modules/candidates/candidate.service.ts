import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { Candidate } from '../../database/entities/candidate.entity';
import { Leader } from '../../database/entities/leader.entity';
import { User } from '../../database/entities/user.entity';
import { CreateCandidateDto } from './dto/create-candidate.dto';
import { UpdateCandidateDto } from './dto/update-candidate.dto';
import { Campaign } from 'src/database/entities';

@Injectable()
export class CandidateService {
  constructor(
    @InjectRepository(Candidate)
    private readonly candidateRepository: Repository<Candidate>,
    @InjectRepository(Leader)
    private readonly leaderRepository: Repository<Leader>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    @InjectRepository(Campaign)
    private readonly campaignRepository: Repository<Campaign>,
  ) {}

  async create(createCandidateDto: CreateCandidateDto): Promise<Candidate> {
    const candidate = this.candidateRepository.create(createCandidateDto);
    return await this.candidateRepository.save(candidate);
  }

  async findAll(): Promise<Candidate[]> {
    return await this.candidateRepository.find({ relations: ['corporation', 'organization'] });
  }

  async findAllWithPagination(
    page: number = 1,
    limit: number = 10,
    search?: string,
    organizationId?: number,
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
      .leftJoinAndSelect('candidate.corporation', 'corporation')
      .leftJoinAndSelect('candidate.organization', 'organization')
      .leftJoinAndSelect('candidate.campaign', 'campaign');

    // Filtrar por organizationId si se proporciona
    if (organizationId) {
      query.where('candidate.organizationId = :organizationId', { organizationId });
    }

    if (search && search.trim()) {
      const searchCondition = `(
        LOWER(candidate.name) LIKE LOWER(:search)
        OR LOWER(candidate.party) LIKE LOWER(:search)
        OR CAST(candidate.number AS CHAR) LIKE :searchNumber
      )`;
      
      if (organizationId) {
        query.andWhere(searchCondition, {
          search: `%${search}%`,
          searchNumber: `%${search}%`,
        });
      } else {
        query.where(searchCondition, {
          search: `%${search}%`,
          searchNumber: `%${search}%`,
        });
      }
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
      relations: ['corporation', 'organization', 'leaders', 'campaign'],
    });
  }

  async findByUserId(userId: number): Promise<Candidate | null> {
    return await this.candidateRepository.findOne({
      where: { userId },
      relations: ['corporation', 'organization', 'leaders', 'campaign'],
    });
  }

  async findByCampaignIds(campaignIds: number[]): Promise<Candidate[]> {
    return await this.candidateRepository.find({
      where: { campaignId: In(campaignIds) },
      relations: ['corporation', 'organization', 'leaders', 'campaign'],
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
    const candidate = await this.candidateRepository.findOne({
      where: { id },
      relations: ['leaders', 'user'],
    });

    if (candidate) {
      if (candidate.userId) {
        await this.userRepository.delete(candidate.userId);
      }

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
      .leftJoinAndSelect('candidate.organization', 'organization')
      .leftJoinAndSelect('candidate.campaign', 'campaign')
      .where('candidate.corporation_id = :corporationId', { corporationId })
      .setParameter('leaderId', leaderId)
      .setParameter('corporationId', corporationId)
      .getMany();
  }
}
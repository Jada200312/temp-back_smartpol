import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Leader } from '../../database/entities/leader.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { User } from '../../database/entities/user.entity';
import { CreateLeaderDto } from './dto/create-leader.dto';
import { UpdateLeaderDto } from './dto/update-leader.dto';

@Injectable()
export class LeaderService {
  constructor(
    @InjectRepository(Leader)
    private readonly leaderRepository: Repository<Leader>,
    @InjectRepository(Candidate)
    private readonly candidateRepository: Repository<Candidate>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async create(createLeaderDto: CreateLeaderDto): Promise<Leader> {
    const leader = this.leaderRepository.create(createLeaderDto);
    return await this.leaderRepository.save(leader);
  }

  async findAll(): Promise<Leader[]> {
    return await this.leaderRepository.find();
  }

  async findAllWithPagination(
    page: number = 1,
    limit: number = 10,
    search?: string,
  ): Promise<{
    data: Leader[];
    total: number;
    page: number;
    limit: number;
    pages: number;
  }> {
    const skip = (page - 1) * limit;
    const query = this.leaderRepository.createQueryBuilder('leader');

    if (search && search.trim()) {
      query
        .where('LOWER(leader.name) LIKE LOWER(:search)', {
          search: `%${search}%`,
        })
        .orWhere('LOWER(leader.document) LIKE LOWER(:search)', {
          search: `%${search}%`,
        })
        .orWhere('LOWER(leader.municipality) LIKE LOWER(:search)', {
          search: `%${search}%`,
        });
    }

    const [leaders, total] = await query
      .skip(skip)
      .take(limit)
      .getManyAndCount();

    return {
      data: leaders,
      total,
      page,
      limit,
      pages: Math.ceil(total / limit),
    };
  }

  async findOne(id: number): Promise<Leader | null> {
    return await this.leaderRepository.findOneBy({ id });
  }

  async update(
    id: number,
    updateLeaderDto: UpdateLeaderDto,
  ): Promise<Leader | null> {
    await this.leaderRepository.update(id, updateLeaderDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    // Cargar el líder con su usuario asociado
    const leader = await this.leaderRepository.findOne({
      where: { id },
      relations: ['candidates', 'user'],
    });

    if (leader) {
      // Si el líder tiene un usuario asociado, eliminarlo también
      if (leader.userId) {
        await this.userRepository.delete(leader.userId);
      }

      // TypeORM eliminará automáticamente las relaciones en candidate_leader
      // porque tenemos cascade: true y onDelete: 'CASCADE' configurados
      await this.leaderRepository.remove(leader);
    }
  }

  async getCandidates(leaderId: number): Promise<Candidate[]> {
    const leader = await this.leaderRepository.findOne({
      where: { id: leaderId },
      relations: ['candidates', 'candidates.corporation'],
    });

    if (!leader) {
      return [];
    }

    return leader.candidates;
  }

  async assignCandidates(
    leaderId: number,
    candidateIds: number[],
  ): Promise<Leader> {
    const leader = await this.leaderRepository.findOne({
      where: { id: leaderId },
      relations: ['candidates'],
    });

    if (!leader) {
      throw new Error('Leader not found');
    }

    // Obtener los candidatos por sus IDs
    const candidates = await this.candidateRepository.findByIds(candidateIds);

    // Asignar los candidatos al líder (reemplazar completamente)
    leader.candidates = candidates;

    return await this.leaderRepository.save(leader);
  }

  async addCandidates(
    leaderId: number,
    candidateIds: number[],
  ): Promise<Leader> {
    const leader = await this.leaderRepository.findOne({
      where: { id: leaderId },
      relations: ['candidates'],
    });

    if (!leader) {
      throw new Error('Leader not found');
    }

    // Obtener los candidatos por sus IDs
    const candidates = await this.candidateRepository.findByIds(candidateIds);

    // Agregar los candidatos sin reemplazar los existentes
    leader.candidates = [...leader.candidates, ...candidates];

    return await this.leaderRepository.save(leader);
  }

  async removeCandidates(
    leaderId: number,
    candidateIds: number[],
  ): Promise<Leader> {
    const leader = await this.leaderRepository.findOne({
      where: { id: leaderId },
      relations: ['candidates'],
    });

    if (!leader) {
      throw new Error('Leader not found');
    }

    // Filtrar los candidatos para remover los especificados
    leader.candidates = leader.candidates.filter(
      (c) => !candidateIds.includes(c.id),
    );

    return await this.leaderRepository.save(leader);
  }
}

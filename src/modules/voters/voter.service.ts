import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Voter } from '../../database/entities/voter.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { Leader } from '../../database/entities/leader.entity';
import { CandidateVoter } from '../../database/entities/candidate-voter.entity';
import { CreateVoterDto } from './dto/create-voter.dto';
import { UpdateVoterDto } from './dto/update-voter.dto';
import { AssignCandidateDto } from './dto/assign-candidate.dto';
import { VoterReportFilterDto, VoterReportDto } from './dto/voter-report.dto';
import {
  PaginationQueryDto,
  PaginatedResponseDto,
} from './dto/pagination-query.dto';

@Injectable()
export class VoterService {
  constructor(
    @InjectRepository(Voter)
    private readonly voterRepository: Repository<Voter>,
    @InjectRepository(Candidate)
    private readonly candidateRepository: Repository<Candidate>,
    @InjectRepository(Leader)
    private readonly leaderRepository: Repository<Leader>,
    @InjectRepository(CandidateVoter)
    private readonly candidateVoterRepository: Repository<CandidateVoter>,
  ) {}

  async create(createVoterDto: CreateVoterDto): Promise<Voter> {
    const voter = this.voterRepository.create(createVoterDto);
    return await this.voterRepository.save(voter);
  }

  async findAll(): Promise<Voter[]> {
    return await this.voterRepository.find();
  }

  async findAllPaginated(
    paginationQueryDto: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<Voter>> {
    const { page = 1, limit = 20 } = paginationQueryDto;
    const skip = (page - 1) * limit;

    const [data, total] = await this.voterRepository.findAndCount({
      skip,
      take: limit,
    });

    const pages = Math.ceil(total / limit);
    const hasNextPage = page < pages;
    const hasPreviousPage = page > 1;

    return {
      data,
      page,
      limit,
      total,
      pages,
      hasNextPage,
      hasPreviousPage,
    };
  }

  async findOne(id: number): Promise<Voter | null> {
    return await this.voterRepository.findOneBy({ id });
  }

  async update(
    id: number,
    updateVoterDto: UpdateVoterDto,
  ): Promise<Voter | null> {
    // Obtén el votante actual
    const voter = await this.voterRepository.findOneBy({ id });

    if (!voter) {
      throw new Error(`Votante con ID ${id} no encontrado`);
    }

    // Si se intenta actualizar identification, verifica que no exista en otro votante
    if (
      updateVoterDto.identification &&
      updateVoterDto.identification !== voter.identification
    ) {
      const existingIdentification = await this.voterRepository.findOneBy({
        identification: updateVoterDto.identification,
      });
      if (existingIdentification) {
        throw new Error(
          `La identificación ${updateVoterDto.identification} ya existe`,
        );
      }
    }

    // Si se intenta actualizar email, verifica que no exista en otro votante
    if (updateVoterDto.email && updateVoterDto.email !== voter.email) {
      const existingEmail = await this.voterRepository.findOneBy({
        email: updateVoterDto.email,
      });
      if (existingEmail) {
        throw new Error(`El email ${updateVoterDto.email} ya existe`);
      }
    }

    // Actualiza todos los campos
    await this.voterRepository.update(id, updateVoterDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    // Primero obtén el votante con sus candidatos
    const voter = await this.voterRepository.findOne({
      where: { id },
      relations: ['candidates'],
    });

    if (!voter) {
      throw new Error(`Votante con ID ${id} no encontrado`);
    }

    // Limpia la relación muchos a muchos
    voter.candidates = [];
    await this.voterRepository.save(voter);

    // Ahora sí puedes borrar el votante
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

    const candidate = await this.candidateRepository.findOneBy({
      id: candidateId,
    });

    if (!candidate) {
      throw new Error(`Candidato con ID ${candidateId} no encontrado`);
    }

    voter.candidates.push(candidate);
    return await this.voterRepository.save(voter);
  }

  async getAssignedCandidates(voterId: number): Promise<CandidateVoter[]> {
    const voter = await this.voterRepository.findOneBy({ id: voterId });

    if (!voter) {
      throw new Error(`Votante con ID ${voterId} no encontrado`);
    }

    const assignments = await this.candidateVoterRepository.find({
      where: { voterId },
      relations: ['candidate', 'leader'],
    });

    return assignments;
  }

  async updateAssignedCandidates(
    voterId: number,
    assignCandidateDto: AssignCandidateDto,
  ): Promise<CandidateVoter[]> {
    const voter = await this.voterRepository.findOneBy({ id: voterId });

    if (!voter) {
      throw new Error(`Votante con ID ${voterId} no encontrado`);
    }

    // Validar que el líder existe
    const leader = await this.leaderRepository.findOneBy({
      id: assignCandidateDto.leader_id,
    });

    if (!leader) {
      throw new Error(
        `Líder con ID ${assignCandidateDto.leader_id} no encontrado`,
      );
    }

    // Validar que todos los candidatos existen
    for (const candidateId of assignCandidateDto.candidate_ids) {
      const candidate = await this.candidateRepository.findOneBy({
        id: candidateId,
      });

      if (!candidate) {
        throw new Error(`Candidato con ID ${candidateId} no encontrado`);
      }
    }

    // Eliminar asignaciones previas para este votante
    await this.candidateVoterRepository.delete({ voterId });

    // Crear nuevas asignaciones
    for (const candidateId of assignCandidateDto.candidate_ids) {
      await this.candidateVoterRepository
        .createQueryBuilder()
        .insert()
        .into(CandidateVoter)
        .values({
          voterId,
          candidateId,
          leaderId: assignCandidateDto.leader_id,
        })
        .execute();
    }

    // Retornar las asignaciones actualizado con las relaciones
    const results = await this.candidateVoterRepository.find({
      where: { voterId },
      relations: ['candidate', 'leader'],
    });

    if (!results || results.length === 0) {
      throw new Error('Error al recuperar las asignaciones creadas');
    }

    return results;
  }

  async getVoterReport(
    filters: VoterReportFilterDto,
  ): Promise<{ data: VoterReportDto[]; total: number; aggregations: any }> {
    let query = this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.voter', 'voter')
      .leftJoinAndSelect('voter.department', 'department')
      .leftJoinAndSelect('voter.municipality', 'municipality')
      .leftJoinAndSelect('cv.candidate', 'candidate')
      .leftJoinAndSelect('candidate.corporation', 'corporation')
      .leftJoinAndSelect('cv.leader', 'leader');

    // Aplicar filtros
    if (filters.gender) {
      query = query.andWhere('voter.gender = :gender', {
        gender: filters.gender,
      });
    }

    if (filters.leaderId) {
      const leaderId = parseInt(filters.leaderId as any);
      if (!isNaN(leaderId)) {
        query = query.andWhere('cv.leaderId = :leaderId', { leaderId });
      }
    }

    if (filters.candidateId) {
      const candidateId = parseInt(filters.candidateId as any);
      if (!isNaN(candidateId)) {
        query = query.andWhere('cv.candidateId = :candidateId', {
          candidateId,
        });
      }
    }

    if (filters.corporationId) {
      const corporationId = parseInt(filters.corporationId as any);
      if (!isNaN(corporationId)) {
        query = query.andWhere('candidate.corporation_id = :corporationId', {
          corporationId,
        });
      }
    }

    if (filters.departmentId) {
      const departmentId = parseInt(filters.departmentId as any);
      if (!isNaN(departmentId)) {
        query = query.andWhere('voter.departmentId = :departmentId', {
          departmentId,
        });
      }
    }

    if (filters.municipalityId) {
      const municipalityId = parseInt(filters.municipalityId as any);
      if (!isNaN(municipalityId)) {
        query = query.andWhere('voter.municipalityId = :municipalityId', {
          municipalityId,
        });
      }
    }

    if (filters.votingLocation) {
      query = query.andWhere('voter.votingLocation ILIKE :votingLocation', {
        votingLocation: `%${filters.votingLocation}%`,
      });
    }

    // Contar total antes de paginar
    const total = await query.getCount();

    // Aplicar paginación
    const page = Math.max(1, parseInt(filters.page as any) || 1);
    const limit = Math.max(1, parseInt(filters.limit as any) || 50);
    const skip = (page - 1) * limit;

    query = query.skip(skip).take(limit);

    const results = await query.getMany();

    // Agrupar resultados por votante para evitar duplicados
    const votersMap = new Map<number, VoterReportDto>();

    results.forEach((assignment) => {
      const voterId = assignment.voter.id;
      if (!votersMap.has(voterId)) {
        votersMap.set(voterId, {
          id: assignment.voter.id,
          firstName: assignment.voter.firstName,
          lastName: assignment.voter.lastName,
          identification: assignment.voter.identification,
          gender: assignment.voter.gender,
          phone: assignment.voter.phone,
          email: assignment.voter.email,
          departmentId: assignment.voter.departmentId,
          department: assignment.voter.department
            ? {
                id: assignment.voter.department.id,
                name: assignment.voter.department.name,
              }
            : undefined,
          municipalityId: assignment.voter.municipalityId,
          municipality: assignment.voter.municipality
            ? {
                id: assignment.voter.municipality.id,
                name: assignment.voter.municipality.name,
              }
            : undefined,
          neighborhood: assignment.voter.neighborhood,
          votingLocation: assignment.voter.votingLocation,
          votingBooth: assignment.voter.votingBooth,
          candidates: [],
          leaders: [],
        });
      }

      const voter = votersMap.get(voterId);

      if (!voter) return; // Skip if voter not found

      // Agregar candidato si no existe
      if (assignment.candidate) {
        const candidateExists = (voter.candidates || []).some(
          (c) => c.id === assignment.candidate.id,
        );
        if (!candidateExists) {
          if (!voter.candidates) voter.candidates = [];
          voter.candidates.push({
            id: assignment.candidate.id,
            name: assignment.candidate.name,
            party: assignment.candidate.party,
            number: assignment.candidate.number,
            corporation: assignment.candidate.corporation
              ? {
                  id: assignment.candidate.corporation.id,
                  name: assignment.candidate.corporation.name,
                }
              : undefined,
          });
        }
      }

      // Agregar líder si no existe
      if (assignment.leader) {
        const leaderExists = (voter.leaders || []).some(
          (l) => l.id === assignment.leader?.id,
        );
        if (!leaderExists) {
          if (!voter.leaders) voter.leaders = [];
          voter.leaders.push({
            id: assignment.leader.id,
            name: assignment.leader.name,
          });
        }
      }
    });

    // Obtener agregaciones
    const aggregations = await this.getAggregations(filters);

    return {
      data: Array.from(votersMap.values()),
      total: votersMap.size,
      aggregations,
    };
  }

  private async getAggregations(filters: VoterReportFilterDto): Promise<any> {
    // Agregación por género
    const genderCount = await this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.voter', 'voter')
      .select('voter.gender', 'gender')
      .addSelect('COUNT(DISTINCT voter.id)', 'count')
      .groupBy('voter.gender')
      .getRawMany();

    // Agregación por líder
    const leaderCount = await this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.leader', 'leader')
      .select('leader.id', 'id')
      .addSelect('leader.name', 'name')
      .addSelect('COUNT(DISTINCT cv.voterId)', 'count')
      .groupBy('leader.id')
      .addGroupBy('leader.name')
      .getRawMany();

    // Agregación por candidato
    const candidateCount = await this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.candidate', 'candidate')
      .leftJoinAndSelect('candidate.corporation', 'corporation')
      .select('candidate.id', 'id')
      .addSelect('candidate.name', 'name')
      .addSelect('corporation.name', 'corporationName')
      .addSelect('COUNT(DISTINCT cv.voterId)', 'count')
      .groupBy('candidate.id')
      .addGroupBy('candidate.name')
      .addGroupBy('corporation.name')
      .getRawMany();

    // Agregación por ubicación (departamento/municipio)
    const locationCount = await this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.voter', 'voter')
      .leftJoinAndSelect('voter.department', 'department')
      .leftJoinAndSelect('voter.municipality', 'municipality')
      .select('department.id', 'departmentId')
      .addSelect('department.name', 'departmentName')
      .addSelect('municipality.id', 'municipalityId')
      .addSelect('municipality.name', 'municipalityName')
      .addSelect('COUNT(DISTINCT voter.id)', 'count')
      .groupBy('department.id')
      .addGroupBy('department.name')
      .addGroupBy('municipality.id')
      .addGroupBy('municipality.name')
      .getRawMany();

    return {
      byGender: genderCount,
      byLeader: leaderCount,
      byCandidate: candidateCount,
      byLocation: locationCount,
    };
  }
}

import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Voter } from '../../database/entities/voter.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { Leader } from '../../database/entities/leader.entity';
import { CandidateVoter } from '../../database/entities/candidate-voter.entity';
import { Department } from '../../database/entities/department.entity';
import { Municipality } from '../../database/entities/municipality.entity';
import { VotingBooth } from '../../database/entities/voting-booth.entity';
import { VotingTable } from '../../database/entities/voting-table.entity';
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
    @InjectRepository(Department)
    private readonly departmentRepository: Repository<Department>,
    @InjectRepository(Municipality)
    private readonly municipalityRepository: Repository<Municipality>,
    @InjectRepository(VotingBooth)
    private readonly votingBoothRepository: Repository<VotingBooth>,
    @InjectRepository(VotingTable)
    private readonly votingTableRepository: Repository<VotingTable>,
  ) {}

  async create(createVoterDto: CreateVoterDto): Promise<Voter> {
    // Validar que el departamento existe
    if (createVoterDto.departmentId) {
      const department = await this.departmentRepository.findOneBy({
        id: createVoterDto.departmentId,
      });
      if (!department) {
        throw new BadRequestException(
          `Departamento con ID ${createVoterDto.departmentId} no encontrado`,
        );
      }
    }

    // Validar que el municipio existe
    if (createVoterDto.municipalityId) {
      const municipality = await this.municipalityRepository.findOneBy({
        id: createVoterDto.municipalityId,
      });
      if (!municipality) {
        throw new BadRequestException(
          `Municipio con ID ${createVoterDto.municipalityId} no encontrado`,
        );
      }
    }

    // Validar que el puesto de votación existe
    if (createVoterDto.votingBoothId) {
      const votingBooth = await this.votingBoothRepository.findOneBy({
        id: createVoterDto.votingBoothId,
      });
      if (!votingBooth) {
        throw new BadRequestException(
          `Puesto de votación con ID ${createVoterDto.votingBoothId} no encontrado`,
        );
      }
    }

    // Validar que la mesa de votación existe
    if (createVoterDto.votingTableId) {
      const votingTable = await this.votingTableRepository.findOneBy({
        id: createVoterDto.votingTableId,
      });
      if (!votingTable) {
        throw new BadRequestException(
          `Mesa de votación con ID ${createVoterDto.votingTableId} no encontrado`,
        );
      }
    }

    // Verificar que identification sea única
    const existingIdentification = await this.voterRepository.findOneBy({
      identification: createVoterDto.identification,
    });
    if (existingIdentification) {
      throw new BadRequestException(
        `La identificación ${createVoterDto.identification} ya existe`,
      );
    }

    // Verificar que email sea único
    const existingEmail = await this.voterRepository.findOneBy({
      email: createVoterDto.email,
    });
    if (existingEmail) {
      throw new BadRequestException(
        `El email ${createVoterDto.email} ya existe`,
      );
    }

    const voter = this.voterRepository.create(createVoterDto);
    return await this.voterRepository.save(voter);
  }

  async findAll(): Promise<Voter[]> {
    return await this.voterRepository.find({
      relations: ['department', 'municipality', 'votingBooth', 'votingTable'],
    });
  }

  async findAllPaginated(
    paginationQueryDto: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<Voter>> {
    const { page = 1, limit = 20 } = paginationQueryDto;
    const skip = (page - 1) * limit;

    const [data, total] = await this.voterRepository.findAndCount({
      skip,
      take: limit,
      relations: ['department', 'municipality', 'votingBooth', 'votingTable'],
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

  async findOne(id: number): Promise<Voter> {
    const voter = await this.voterRepository.findOne({
      where: { id },
      relations: ['department', 'municipality', 'votingBooth', 'votingTable'],
    });

    if (!voter) {
      throw new NotFoundException(`Votante con ID ${id} no encontrado`);
    }

    return voter;
  }

  async update(id: number, updateVoterDto: UpdateVoterDto): Promise<Voter> {
    // Obtén el votante actual
    const voter = await this.voterRepository.findOneBy({ id });

    if (!voter) {
      throw new NotFoundException(`Votante con ID ${id} no encontrado`);
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
        throw new BadRequestException(
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
        throw new BadRequestException(
          `El email ${updateVoterDto.email} ya existe`,
        );
      }
    }

    // Validar que el departamento existe si se actualiza
    if (updateVoterDto.departmentId) {
      const department = await this.departmentRepository.findOneBy({
        id: updateVoterDto.departmentId,
      });
      if (!department) {
        throw new BadRequestException(
          `Departamento con ID ${updateVoterDto.departmentId} no encontrado`,
        );
      }
    }

    // Validar que el municipio existe si se actualiza
    if (updateVoterDto.municipalityId) {
      const municipality = await this.municipalityRepository.findOneBy({
        id: updateVoterDto.municipalityId,
      });
      if (!municipality) {
        throw new BadRequestException(
          `Municipio con ID ${updateVoterDto.municipalityId} no encontrado`,
        );
      }
    }

    // Validar que el puesto de votación existe si se actualiza
    if (updateVoterDto.votingBoothId) {
      const votingBooth = await this.votingBoothRepository.findOneBy({
        id: updateVoterDto.votingBoothId,
      });
      if (!votingBooth) {
        throw new BadRequestException(
          `Puesto de votación con ID ${updateVoterDto.votingBoothId} no encontrado`,
        );
      }
    }

    // Validar que la mesa de votación existe si se actualiza
    if (updateVoterDto.votingTableId) {
      const votingTable = await this.votingTableRepository.findOneBy({
        id: updateVoterDto.votingTableId,
      });
      if (!votingTable) {
        throw new BadRequestException(
          `Mesa de votación con ID ${updateVoterDto.votingTableId} no encontrado`,
        );
      }
    }

    // Actualiza todos los campos
    await this.voterRepository.update(id, updateVoterDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    const voter = await this.voterRepository.findOneBy({ id });

    if (!voter) {
      throw new NotFoundException(`Votante con ID ${id} no encontrado`);
    }

    // Eliminar todas las asignaciones de candidatos para este votante
    await this.candidateVoterRepository.delete({ voterId: id });

    // Ahora sí puedes borrar el votante
    await this.voterRepository.delete(id);
  }

  async assignCandidate(voterId: number, candidateId: number): Promise<Voter> {
    const voter = await this.voterRepository.findOne({
      where: { id: voterId },
      relations: ['candidates'],
    });

    if (!voter) {
      throw new NotFoundException(`Votante con ID ${voterId} no encontrado`);
    }

    const candidate = await this.candidateRepository.findOneBy({
      id: candidateId,
    });

    if (!candidate) {
      throw new NotFoundException(
        `Candidato con ID ${candidateId} no encontrado`,
      );
    }

    voter.candidates.push(candidate);
    return await this.voterRepository.save(voter);
  }

  async getAssignedCandidates(voterId: number): Promise<CandidateVoter[]> {
    const voter = await this.voterRepository.findOneBy({ id: voterId });

    if (!voter) {
      throw new NotFoundException(`Votante con ID ${voterId} no encontrado`);
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
      throw new NotFoundException(`Votante con ID ${voterId} no encontrado`);
    }

    // Validar que el líder existe
    const leader = await this.leaderRepository.findOneBy({
      id: assignCandidateDto.leader_id,
    });

    if (!leader) {
      throw new NotFoundException(
        `Líder con ID ${assignCandidateDto.leader_id} no encontrado`,
      );
    }

    // Validar que todos los candidatos existen
    for (const candidateId of assignCandidateDto.candidate_ids) {
      const candidate = await this.candidateRepository.findOneBy({
        id: candidateId,
      });

      if (!candidate) {
        throw new NotFoundException(
          `Candidato con ID ${candidateId} no encontrado`,
        );
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
      throw new BadRequestException(
        'Error al recuperar las asignaciones creadas',
      );
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
      .leftJoinAndSelect('voter.votingBooth', 'votingBooth')
      .leftJoinAndSelect('voter.votingTable', 'votingTable')
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

    if (filters.votingBoothId) {
      const votingBoothId = parseInt(filters.votingBoothId as any);
      if (!isNaN(votingBoothId)) {
        query = query.andWhere('voter.votingBoothId = :votingBoothId', {
          votingBoothId,
        });
      }
    }

    if (filters.votingTableId) {
      const votingTableId = parseInt(filters.votingTableId as any);
      if (!isNaN(votingTableId)) {
        query = query.andWhere('voter.votingTableId = :votingTableId', {
          votingTableId,
        });
      }
    }

    // Obtener TODOS los resultados sin paginación para agrupar correctamente
    const allResults = await query.getMany();

    // Agrupar resultados por votante para evitar duplicados
    const votersMap = new Map<number, VoterReportDto>();

    allResults.forEach((assignment) => {
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
          votingBoothId: assignment.voter.votingBoothId,
          votingBooth: assignment.voter.votingBooth
            ? {
                id: assignment.voter.votingBooth.id,
                name: assignment.voter.votingBooth.name,
                code: assignment.voter.votingBooth.code,
              }
            : undefined,
          votingTableId: assignment.voter.votingTableId,
          votingTable: assignment.voter.votingTable
            ? {
                id: assignment.voter.votingTable.id,
                tableNumber: assignment.voter.votingTable.tableNumber,
              }
            : undefined,
          candidates: [],
          leaders: [],
        });
      }

      const voter = votersMap.get(voterId);

      if (!voter) return;

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

    // Convertir el mapa a array y aplicar paginación sobre votantes únicos
    const uniqueVoters = Array.from(votersMap.values());
    const total = uniqueVoters.length;

    // Aplicar paginación de votantes (20 por página por defecto)
    const page = Math.max(1, parseInt(filters.page as any) || 1);
    const limit = Math.max(1, parseInt(filters.limit as any) || 20);
    const skip = (page - 1) * limit;

    const paginatedVoters = uniqueVoters.slice(skip, skip + limit);

    // Obtener agregaciones
    const aggregations = await this.getAggregations(filters);

    return {
      data: paginatedVoters,
      total: total,
      aggregations,
    };
  }

  private async getAggregations(filters: VoterReportFilterDto): Promise<any> {
    // Agregación por género
    let genderQuery = this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.voter', 'voter')
      .select('voter.gender', 'gender')
      .addSelect('COUNT(DISTINCT voter.id)', 'count')
      .groupBy('voter.gender');

    // Aplicar filtros a agregaciones
    if (filters.votingBoothId) {
      const votingBoothId = parseInt(filters.votingBoothId as any);
      if (!isNaN(votingBoothId)) {
        genderQuery = genderQuery.andWhere('voter.votingBoothId = :votingBoothId', {
          votingBoothId,
        });
      }
    }

    if (filters.votingTableId) {
      const votingTableId = parseInt(filters.votingTableId as any);
      if (!isNaN(votingTableId)) {
        genderQuery = genderQuery.andWhere('voter.votingTableId = :votingTableId', {
          votingTableId,
        });
      }
    }

    const genderCount = await genderQuery.getRawMany();

    // Agregación por líder
    let leaderQuery = this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.leader', 'leader')
      .leftJoinAndSelect('cv.voter', 'voter')
      .select('leader.id', 'id')
      .addSelect('leader.name', 'name')
      .addSelect('COUNT(DISTINCT cv.voterId)', 'count')
      .groupBy('leader.id')
      .addGroupBy('leader.name');

    if (filters.votingBoothId) {
      const votingBoothId = parseInt(filters.votingBoothId as any);
      if (!isNaN(votingBoothId)) {
        leaderQuery = leaderQuery.andWhere('voter.votingBoothId = :votingBoothId', {
          votingBoothId,
        });
      }
    }

    if (filters.votingTableId) {
      const votingTableId = parseInt(filters.votingTableId as any);
      if (!isNaN(votingTableId)) {
        leaderQuery = leaderQuery.andWhere('voter.votingTableId = :votingTableId', {
          votingTableId,
        });
      }
    }

    const leaderCount = await leaderQuery.getRawMany();

    // Agregación por candidato
    let candidateQuery = this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.candidate', 'candidate')
      .leftJoinAndSelect('candidate.corporation', 'corporation')
      .leftJoinAndSelect('cv.voter', 'voter')
      .select('candidate.id', 'id')
      .addSelect('candidate.name', 'name')
      .addSelect('corporation.name', 'corporationName')
      .addSelect('COUNT(DISTINCT cv.voterId)', 'count')
      .groupBy('candidate.id')
      .addGroupBy('candidate.name')
      .addGroupBy('corporation.name');

    if (filters.votingBoothId) {
      const votingBoothId = parseInt(filters.votingBoothId as any);
      if (!isNaN(votingBoothId)) {
        candidateQuery = candidateQuery.andWhere('voter.votingBoothId = :votingBoothId', {
          votingBoothId,
        });
      }
    }

    if (filters.votingTableId) {
      const votingTableId = parseInt(filters.votingTableId as any);
      if (!isNaN(votingTableId)) {
        candidateQuery = candidateQuery.andWhere('voter.votingTableId = :votingTableId', {
          votingTableId,
        });
      }
    }

    const candidateCount = await candidateQuery.getRawMany();

    // Agregación por ubicación (departamento/municipio)
    let locationQuery = this.candidateVoterRepository
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
      .addGroupBy('municipality.name');

    if (filters.votingBoothId) {
      const votingBoothId = parseInt(filters.votingBoothId as any);
      if (!isNaN(votingBoothId)) {
        locationQuery = locationQuery.andWhere('voter.votingBoothId = :votingBoothId', {
          votingBoothId,
        });
      }
    }

    if (filters.votingTableId) {
      const votingTableId = parseInt(filters.votingTableId as any);
      if (!isNaN(votingTableId)) {
        locationQuery = locationQuery.andWhere('voter.votingTableId = :votingTableId', {
          votingTableId,
        });
      }
    }

    const locationCount = await locationQuery.getRawMany();

    return {
      byGender: genderCount,
      byLeader: leaderCount,
      byCandidate: candidateCount,
      byLocation: locationCount,
    };
  }
}
import {
  Injectable,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, In } from 'typeorm';
import { Voter } from '../../database/entities/voter.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { Leader } from '../../database/entities/leader.entity';
import { CandidateVoter } from '../../database/entities/candidate-voter.entity';
import { Department } from '../../database/entities/department.entity';
import { Municipality } from '../../database/entities/municipality.entity';
import { VotingBooth } from '../../database/entities/voting-booth.entity';
import { VotersHistory } from '../../database/entities/voters-history.entity';
import { CreateVoterDto } from './dto/create-voter.dto';
import { UpdateVoterDto } from './dto/update-voter.dto';
import { AssignCandidateDto } from './dto/assign-candidate.dto';
import { VoterReportFilterDto, VoterReportDto } from './dto/voter-report.dto';
import { VoterSearchByIdentificationDto } from './dto/voter-search-identification.dto';
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
    @InjectRepository(VotersHistory)
    private readonly votersHistoryRepository: Repository<VotersHistory>,
  ) {}

  async create(
    createVoterDto: CreateVoterDto,
    createdByUserId?: number,
  ): Promise<Voter> {
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

    // Validar que el puesto de votación existe si se actualiza
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

    // Verificar que identification sea única
    const existingIdentification = await this.voterRepository.findOneBy({
      identification: createVoterDto.identification,
    });
    if (existingIdentification) {
      throw new BadRequestException(
        `La identificación ${createVoterDto.identification} ya existe`,
      );
    }

    // Verificar que email sea único (solo si se proporciona)
    if (createVoterDto.email) {
      const existingEmail = await this.voterRepository.findOneBy({
        email: createVoterDto.email,
      });
      if (existingEmail) {
        throw new BadRequestException(
          `El email ${createVoterDto.email} ya existe`,
        );
      }
    }

    const voter = this.voterRepository.create({
      ...createVoterDto,
      createdByUserId,
    });
    return await this.voterRepository.save(voter);
  }

  async findAll(): Promise<Voter[]> {
    return await this.voterRepository.find({
      relations: ['department', 'municipality', 'votingBooth'],
    });
  }

  async findAllPaginated(
    paginationQueryDto: PaginationQueryDto,
    user?: any,
  ): Promise<PaginatedResponseDto<Voter>> {
    const { page = 1, limit = 20 } = paginationQueryDto;
    const skip = (page - 1) * limit;

    // Build where clause
    const where: any = {};

    // If the user is a digitador (roleId = 5), only show voters they created
    // if (user && user.roleId === 5) {
    //   where.createdByUserId = user.id;
    // }

    // If the user is a campaign admin (roleId = 2), filter by organization
    if (user && user.roleId === 2 && user.organizationId) {
      // Get all campaigns for this organization
      const campaigns = await this.voterRepository.query(
        'SELECT id FROM campaigns WHERE "organizationId" = $1',
        [user.organizationId],
      );
      const campaignIds = campaigns.map((c) => c.id);

      // If no campaigns, return empty
      if (campaignIds.length === 0) {
        return {
          data: [],
          page,
          limit,
          total: 0,
          pages: 0,
          hasNextPage: false,
          hasPreviousPage: false,
        };
      }

      // Get voter IDs from three sources using simpler approach
      // 1. From candidates in these campaigns
      const candidateVoterResults = await this.voterRepository.query(
        `SELECT DISTINCT "voter_id" FROM candidate_voter WHERE "candidate_id" IN 
         (SELECT id FROM candidates WHERE "campaignId" IN (${campaignIds.join(',')}))`,
      );
      const candidateVoterIds = candidateVoterResults.map((r) => r.voter_id);

      // 2. From leaders in these campaigns
      const leaderVoterResults = await this.voterRepository.query(
        `SELECT DISTINCT "voter_id" FROM candidate_voter WHERE "leader_id" IN 
         (SELECT id FROM leaders WHERE "campaignId" IN (${campaignIds.join(',')}))`,
      );
      const leaderVoterIds = leaderVoterResults.map((r) => r.voter_id);

      // 3. From digitadores in this organization
      const digitadorVoterResults = await this.voterRepository.query(
        `SELECT DISTINCT id FROM voters WHERE "createdByUserId" IN 
         (SELECT id FROM users WHERE "organizationId" = $1)`,
        [user.organizationId],
      );
      const digitadorVoterIds = digitadorVoterResults.map((r) => r.id);

      // Combine and deduplicate
      const allVoterIds = [
        ...new Set([
          ...candidateVoterIds,
          ...leaderVoterIds,
          ...digitadorVoterIds,
        ]),
      ];

      if (allVoterIds.length === 0) {
        return {
          data: [],
          page,
          limit,
          total: 0,
          pages: 0,
          hasNextPage: false,
          hasPreviousPage: false,
        };
      }

      // Get paginated results
      const voters = await this.voterRepository.find({
        where: { id: In(allVoterIds) },
        skip,
        take: limit,
        relations: ['department', 'municipality', 'votingBooth'],
      });

      // Count total
      const total = allVoterIds.length;

      // Fetch candidates and leaders separately
      const voterIds = voters.map((v) => v.id);
      if (voterIds.length > 0) {
        const candidateVoters = await this.candidateVoterRepository.find({
          where: { voterId: In(voterIds) },
          relations: ['candidate', 'leader'],
        });

        const candidateMap = new Map();
        const leaderMap = new Map();

        candidateVoters.forEach((cv) => {
          if (!candidateMap.has(cv.voterId)) {
            candidateMap.set(cv.voterId, []);
          }
          if (cv.candidate) {
            candidateMap.get(cv.voterId).push(cv.candidate);
          }

          if (!leaderMap.has(cv.voterId)) {
            leaderMap.set(cv.voterId, []);
          }
          if (cv.leader) {
            leaderMap.get(cv.voterId).push(cv.leader);
          }
        });

        voters.forEach((voter) => {
          voter.candidates = candidateMap.get(voter.id) || [];
          voter.leaders = leaderMap.get(voter.id) || [];
        });
      } else {
        voters.forEach((voter) => {
          voter.candidates = [];
          voter.leaders = [];
        });
      }

      const pages = Math.ceil(total / limit);
      const hasNextPage = page < pages;
      const hasPreviousPage = page > 1;

      return {
        data: voters,
        page,
        limit,
        total,
        pages,
        hasNextPage,
        hasPreviousPage,
      };
    }

    // Fetch voters without many-to-many relations to avoid cartesian product issues with pagination
    const [voters, total] = await this.voterRepository.findAndCount({
      where,
      skip,
      take: limit,
      relations: ['department', 'municipality', 'votingBooth'],
    });

    // Fetch candidates and leaders separately
    const voterIds = voters.map((v) => v.id);
    if (voterIds.length > 0) {
      // Get candidates
      const candidateVoters = await this.candidateVoterRepository.find({
        where: { voterId: In(voterIds) },
        relations: ['candidate', 'leader'],
      });

      // Group by voter
      const candidateMap = new Map();
      const leaderMap = new Map();

      candidateVoters.forEach((cv) => {
        // Map candidates
        if (!candidateMap.has(cv.voterId)) {
          candidateMap.set(cv.voterId, []);
        }
        if (cv.candidate) {
          candidateMap.get(cv.voterId).push(cv.candidate);
        }

        // Map leaders
        if (!leaderMap.has(cv.voterId)) {
          leaderMap.set(cv.voterId, []);
        }
        if (cv.leader) {
          leaderMap.get(cv.voterId).push(cv.leader);
        }
      });

      // Enrich voters with candidates and leaders
      voters.forEach((voter) => {
        voter.candidates = candidateMap.get(voter.id) || [];
        voter.leaders = leaderMap.get(voter.id) || [];
      });
    } else {
      voters.forEach((voter) => {
        voter.candidates = [];
        voter.leaders = [];
      });
    }

    const pages = Math.ceil(total / limit);
    const hasNextPage = page < pages;
    const hasPreviousPage = page > 1;

    return {
      data: voters,
      page,
      limit,
      total,
      pages,
      hasNextPage,
      hasPreviousPage,
    };
  }

  async findOneWithAllRelations(id: number): Promise<Voter> {
    // Carga TODOS los datos necesarios para el modal de editar
    const voter = await this.voterRepository.findOne({
      where: { id },
      relations: ['department', 'municipality', 'votingBooth'],
    });

    if (!voter) {
      throw new NotFoundException(`Votante con ID ${id} no encontrado`);
    }

    // Traer candidatos_voter con líderes
    const candidateVoters = await this.candidateVoterRepository.find({
      where: { voterId: id },
      relations: ['candidate', 'leader'],
    });

    // Injetar líderes en el votante
    voter.leaders = candidateVoters
      .filter((cv) => cv.leader !== null && cv.leader !== undefined)
      .map((cv) => cv.leader as Leader);

    // Injetar candidatos en el votante
    voter.candidates = candidateVoters
      .map((cv) => cv.candidate)
      .filter(Boolean);

    return voter;
  }

  async findByCandidatePaginated(
    candidateId: number,
    paginationQueryDto: PaginationQueryDto,
    user?: any,
  ): Promise<PaginatedResponseDto<Voter>> {
    const { page = 1, limit = 20 } = paginationQueryDto;
    const skip = (page - 1) * limit;

    // If user is campaign admin (roleId=2), verify the candidate belongs to their organization
    if (user && user.roleId === 2 && user.organizationId) {
      const candidate = await this.candidateRepository.findOne({
        where: { id: candidateId },
        relations: ['campaign'],
      });

      if (
        !candidate ||
        !candidate.campaign ||
        candidate.campaign.organizationId !== user.organizationId
      ) {
        // Return empty result if candidate doesn't belong to user's organization
        return {
          data: [],
          page,
          limit,
          total: 0,
          pages: 0,
          hasNextPage: false,
          hasPreviousPage: false,
        };
      }
    }

    // Fetch voters for this candidate
    const candidateVoters = await this.candidateVoterRepository.find({
      where: { candidateId },
      select: ['voterId'],
    });

    const voterIds = candidateVoters.map((cv) => cv.voterId);

    // If no voters are assigned to this candidate, return empty result
    if (voterIds.length === 0) {
      return {
        data: [],
        page,
        limit,
        total: 0,
        pages: 0,
        hasNextPage: false,
        hasPreviousPage: false,
      };
    }

    const [voters, total] = await this.voterRepository.findAndCount({
      where: { id: In(voterIds) },
      skip,
      take: limit,
      relations: ['department', 'municipality', 'votingBooth'],
    });

    if (voters.length > 0) {
      const allCandidateVoters = await this.candidateVoterRepository.find({
        where: { voterId: In(voters.map((v) => v.id)) },
        relations: ['candidate', 'leader'],
      });

      const candidateMap = new Map();
      const leaderMap = new Map();

      allCandidateVoters.forEach((cv) => {
        if (!candidateMap.has(cv.voterId)) {
          candidateMap.set(cv.voterId, []);
        }
        if (cv.candidate) {
          candidateMap.get(cv.voterId).push(cv.candidate);
        }

        if (!leaderMap.has(cv.voterId)) {
          leaderMap.set(cv.voterId, []);
        }
        if (cv.leader) {
          leaderMap.get(cv.voterId).push(cv.leader);
        }
      });

      voters.forEach((voter) => {
        voter.candidates = candidateMap.get(voter.id) || [];
        voter.leaders = leaderMap.get(voter.id) || [];
      });
    } else {
      voters.forEach((voter) => {
        voter.candidates = [];
        voter.leaders = [];
      });
    }

    const pages = Math.ceil(total / limit);
    const hasNextPage = page < pages;
    const hasPreviousPage = page > 1;

    return {
      data: voters,
      page,
      limit,
      total,
      pages,
      hasNextPage,
      hasPreviousPage,
    };
  }

  async findByLeaderPaginated(
    leaderId: number,
    paginationQueryDto: PaginationQueryDto,
    user?: any,
  ): Promise<PaginatedResponseDto<Voter>> {
    const { page = 1, limit = 20 } = paginationQueryDto;
    const skip = (page - 1) * limit;

    // If user is campaign admin (roleId=2), verify the leader belongs to their organization
    if (user && user.roleId === 2 && user.organizationId) {
      const leader = await this.leaderRepository.findOne({
        where: { id: leaderId },
        relations: ['campaign'],
      });

      if (
        !leader ||
        !leader.campaign ||
        leader.campaign.organizationId !== user.organizationId
      ) {
        // Return empty result if leader doesn't belong to user's organization
        return {
          data: [],
          page,
          limit,
          total: 0,
          pages: 0,
          hasNextPage: false,
          hasPreviousPage: false,
        };
      }
    }

    // Fetch voters for this leader
    const candidateVoters = await this.candidateVoterRepository.find({
      where: { leaderId },
      select: ['voterId'],
    });

    const voterIds = candidateVoters.map((cv) => cv.voterId);

    // If no voters are assigned to this leader, return empty result
    if (voterIds.length === 0) {
      return {
        data: [],
        page,
        limit,
        total: 0,
        pages: 0,
        hasNextPage: false,
        hasPreviousPage: false,
      };
    }

    const [voters, total] = await this.voterRepository.findAndCount({
      where: { id: In(voterIds) },
      skip,
      take: limit,
      relations: ['department', 'municipality', 'votingBooth'],
    });

    if (voters.length > 0) {
      const allCandidateVoters = await this.candidateVoterRepository.find({
        where: { voterId: In(voters.map((v) => v.id)) },
        relations: ['candidate', 'leader'],
      });

      const candidateMap = new Map();
      const leaderMap = new Map();

      allCandidateVoters.forEach((cv) => {
        if (!candidateMap.has(cv.voterId)) {
          candidateMap.set(cv.voterId, []);
        }
        if (cv.candidate) {
          candidateMap.get(cv.voterId).push(cv.candidate);
        }

        if (!leaderMap.has(cv.voterId)) {
          leaderMap.set(cv.voterId, []);
        }
        if (cv.leader) {
          leaderMap.get(cv.voterId).push(cv.leader);
        }
      });

      voters.forEach((voter) => {
        voter.candidates = candidateMap.get(voter.id) || [];
        voter.leaders = leaderMap.get(voter.id) || [];
      });
    } else {
      voters.forEach((voter) => {
        voter.candidates = [];
        voter.leaders = [];
      });
    }

    const pages = Math.ceil(total / limit);
    const hasNextPage = page < pages;
    const hasPreviousPage = page > 1;

    return {
      data: voters,
      page,
      limit,
      total,
      pages,
      hasNextPage,
      hasPreviousPage,
    };
  }

  async findAllWithAssignmentsByRole(
    roleId?: number,
    candidateId?: number,
    leaderId?: number,
    user?: any,
  ): Promise<Voter[]> {
    // Fetch voters based on role
    let voters: Voter[] = [];

    if (roleId === 3 && candidateId) {
      // Candidato: traer solo sus votantes
      const candidateVoters = await this.candidateVoterRepository.find({
        where: { candidateId },
        select: ['voterId'],
      });
      const voterIds = candidateVoters.map((cv) => cv.voterId);
      if (voterIds.length > 0) {
        voters = await this.voterRepository.find({
          where: { id: In(voterIds) },
          relations: ['department', 'municipality', 'votingBooth'],
        });
      }
    } else if (roleId === 4 && leaderId) {
      // Líder: traer solo los votantes de sus candidatos
      const leaderCandidateVoters = await this.candidateVoterRepository.find({
        where: { leaderId },
        select: ['voterId'],
      });
      const voterIds = leaderCandidateVoters.map((cv) => cv.voterId);
      if (voterIds.length > 0) {
        voters = await this.voterRepository.find({
          where: { id: In(voterIds) },
          relations: ['department', 'municipality', 'votingBooth'],
        });
      }
    } else if (roleId === 2 && user && user.organizationId) {
      // Admin de campaña: traer votantes de su organización asociados a:
      // 1. Candidatos de su organización
      // 2. Líderes de su organización
      // 3. Digitadores de su organización

      // Get all campaigns for this organization
      const campaigns = await this.voterRepository.query(
        'SELECT id FROM campaigns WHERE "organizationId" = $1',
        [user.organizationId],
      );
      const campaignIds = campaigns.map((c) => c.id);

      // If campaigns exist, get voters from candidates and leaders
      if (campaignIds.length > 0) {
        // From candidates in these campaigns
        const candidateVoterResults = await this.voterRepository.query(
          `SELECT DISTINCT "voter_id" FROM candidate_voter WHERE "candidate_id" IN 
           (SELECT id FROM candidates WHERE "campaignId" IN (${campaignIds.join(',')}))`,
        );
        const candidateVoterIds = candidateVoterResults.map((r) => r.voter_id);

        // From leaders in these campaigns
        const leaderVoterResults = await this.voterRepository.query(
          `SELECT DISTINCT "voter_id" FROM candidate_voter WHERE "leader_id" IN 
           (SELECT id FROM leaders WHERE "campaignId" IN (${campaignIds.join(',')}))`,
        );
        const leaderVoterIds = leaderVoterResults.map((r) => r.voter_id);

        // From digitadores in this organization
        const digitadorVoterResults = await this.voterRepository.query(
          `SELECT DISTINCT id FROM voters WHERE "createdByUserId" IN 
           (SELECT id FROM users WHERE "organizationId" = $1)`,
          [user.organizationId],
        );
        const digitadorVoterIds = digitadorVoterResults.map((r) => r.id);

        // Combine and deduplicate
        const allVoterIds = [
          ...new Set([
            ...candidateVoterIds,
            ...leaderVoterIds,
            ...digitadorVoterIds,
          ]),
        ];

        if (allVoterIds.length > 0) {
          voters = await this.voterRepository.find({
            where: { id: In(allVoterIds) },
            relations: ['department', 'municipality', 'votingBooth'],
          });
        }
      }
    } else {
      // Otros roles: traer todos los votantes (o filtrar para digitadores)
      const where: any = {};

      // If the user is a digitador (roleId = 5), only show voters they created
      // if (user && user.roleId === 5) {
      //   where.createdByUserId = user.id;
      // }

      voters = await this.voterRepository.find({
        where,
        relations: ['department', 'municipality', 'votingBooth'],
      });
    }

    // Traer asignaciones para todos los voters
    if (voters.length > 0) {
      const voterIds = voters.map((v) => v.id);
      const allCandidateVoters = await this.candidateVoterRepository.find({
        where: { voterId: In(voterIds) },
        relations: ['candidate', 'leader'],
      });

      const candidateMap = new Map();
      const leaderMap = new Map();

      allCandidateVoters.forEach((cv) => {
        if (!candidateMap.has(cv.voterId)) {
          candidateMap.set(cv.voterId, []);
        }
        if (cv.candidate) {
          candidateMap.get(cv.voterId).push(cv.candidate);
        }

        if (!leaderMap.has(cv.voterId)) {
          leaderMap.set(cv.voterId, []);
        }
        if (cv.leader) {
          leaderMap.get(cv.voterId).push(cv.leader);
        }
      });

      voters.forEach((voter) => {
        voter.candidates = candidateMap.get(voter.id) || [];
        voter.leaders = leaderMap.get(voter.id) || [];
      });
    } else {
      voters.forEach((voter) => {
        voter.candidates = [];
        voter.leaders = [];
      });
    }

    return voters;
  }

  async findOne(id: number): Promise<Voter> {
    const voter = await this.voterRepository.findOne({
      where: { id },
    });

    if (!voter) {
      throw new NotFoundException(`Votante con ID ${id} no encontrado`);
    }

    return voter;
  }

  async findByIdentification(identification: string): Promise<Voter | null> {
    const voter = await this.voterRepository.findOne({
      where: { identification },
      select: ['id', 'identification', 'firstName', 'lastName'],
    });

    return voter || null;
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

    // Actualiza todos los campos
    await this.voterRepository.update(id, updateVoterDto);
    return await this.findOneWithAllRelations(id);
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
    user?: any,
  ): Promise<{
    data: VoterReportDto[];
    page: number;
    limit: number;
    total: number;
    pages: number;
    aggregations: any;
  }> {
    let query = this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.voter', 'voter')
      .leftJoinAndSelect('voter.department', 'department')
      .leftJoinAndSelect('voter.municipality', 'municipality')
      .leftJoinAndSelect('voter.votingBooth', 'votingBooth')
      .leftJoinAndSelect('cv.candidate', 'candidate')
      .leftJoinAndSelect('candidate.corporation', 'corporation')
      .leftJoinAndSelect('cv.leader', 'leader');

    // If the user is a digitador (roleId = 5), only show voters they created
    // if (user && user.roleId === 5) {
    //   query = query.andWhere('voter.createdByUserId = :createdByUserId', {
    //     createdByUserId: user.id,
    //   });
    // }

    // Aplicar filtros
    if (filters.gender) {
      query = query.andWhere('voter.gender = :gender', {
        gender: filters.gender,
      });
    }

    if (filters.leaderId) {
      const leaderId = parseInt(filters.leaderId as any);
      if (!isNaN(leaderId) && leaderId > 0) {
        query = query.andWhere('cv.leaderId = :leaderId', { leaderId });
      }
    }

    if (filters.candidateId) {
      const candidateId = parseInt(filters.candidateId as any);
      if (!isNaN(candidateId) && candidateId > 0) {
        query = query.andWhere('cv.candidateId = :candidateId', {
          candidateId,
        });
      }
    }

    if (filters.corporationId) {
      const corporationId = parseInt(filters.corporationId as any);
      if (!isNaN(corporationId) && corporationId > 0) {
        query = query.andWhere('candidate.corporation_id = :corporationId', {
          corporationId,
        });
      }
    }

    if (filters.departmentId) {
      const departmentId = parseInt(filters.departmentId as any);
      if (!isNaN(departmentId) && departmentId > 0) {
        query = query.andWhere('voter.departmentId = :departmentId', {
          departmentId,
        });
      }
    }

    if (filters.municipalityId) {
      const municipalityId = parseInt(filters.municipalityId as any);
      if (!isNaN(municipalityId) && municipalityId > 0) {
        query = query.andWhere('voter.municipalityId = :municipalityId', {
          municipalityId,
        });
      }
    }

    if (filters.votingBoothId) {
      const votingBoothId = parseInt(filters.votingBoothId as any);
      if (!isNaN(votingBoothId) && votingBoothId > 0) {
        query = query.andWhere('voter.votingBoothId = :votingBoothId', {
          votingBoothId,
        });
      }
    }

    if (filters.votingTableId) {
      const votingTableId = parseInt(filters.votingTableId as any);
      if (!isNaN(votingTableId) && votingTableId > 0) {
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
    const aggregations = await this.getAggregations(filters, user);

    return {
      data: paginatedVoters,
      page,
      limit,
      total: total,
      pages: Math.ceil(total / limit),
      aggregations,
    };
  }

  private async getAggregations(
    filters: VoterReportFilterDto,
    user?: any,
  ): Promise<any> {
    // Función helper para aplicar filtros comunes
    const applyFilters = (query: any) => {
      // If the user is a digitador (roleId = 5), only show voters they created
      // if (user && user.roleId === 5) {
      //   query = query.andWhere('voter.createdByUserId = :createdByUserId', {
      //     createdByUserId: user.id,
      //   });
      // }

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

      return query;
    };

    // Crear todas las queries de agregación
    let genderQuery = this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.voter', 'voter')
      .select('voter.gender', 'gender')
      .addSelect('COUNT(DISTINCT voter.id)', 'count')
      .groupBy('voter.gender');
    genderQuery = applyFilters(genderQuery);

    let leaderQuery = this.candidateVoterRepository
      .createQueryBuilder('cv')
      .leftJoinAndSelect('cv.leader', 'leader')
      .leftJoinAndSelect('cv.voter', 'voter')
      .select('leader.id', 'id')
      .addSelect('leader.name', 'name')
      .addSelect('COUNT(DISTINCT cv.voterId)', 'count')
      .groupBy('leader.id')
      .addGroupBy('leader.name');
    leaderQuery = applyFilters(leaderQuery);

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
    candidateQuery = applyFilters(candidateQuery);

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
    locationQuery = applyFilters(locationQuery);

    // Ejecutar todas las queries en PARALELO
    const [genderCount, leaderCount, candidateCount, locationCount] =
      await Promise.all([
        genderQuery.getRawMany(),
        leaderQuery.getRawMany(),
        candidateQuery.getRawMany(),
        locationQuery.getRawMany(),
      ]);

    return {
      byGender: genderCount,
      byLeader: leaderCount,
      byCandidate: candidateCount,
      byLocation: locationCount,
    };
  }

  async searchByIdentification(
    identification: string,
  ): Promise<VoterSearchByIdentificationDto> {
    // Step 1: Check if voter exists in voters table with candidate_voter assignments
    const voter = await this.voterRepository.findOne({
      where: { identification },
    });

    if (voter) {
      // Check if voter has candidate_voter assignments
      const candidateVoterLink = await this.candidateVoterRepository.findOne({
        where: { voterId: voter.id },
        relations: ['candidate', 'candidate.campaign', 'leader'],
      });

      if (candidateVoterLink) {
        // Get all candidates and leader for this voter
        const allAssignments = await this.candidateVoterRepository.find({
          where: { voterId: voter.id },
          relations: ['candidate', 'candidate.campaign', 'leader'],
        });

        const candidates = allAssignments.map((assignment) => ({
          id: assignment.candidate.id,
          name: assignment.candidate.name,
          party: assignment.candidate.party,
          number: assignment.candidate.number,
          campaignName: assignment.candidate.campaign?.name || '',
        }));

        const leader = allAssignments[0]?.leader
          ? {
              id: allAssignments[0].leader.id,
              name: allAssignments[0].leader.name,
              document: allAssignments[0].leader.document,
              municipality: allAssignments[0].leader.municipality,
              phone: allAssignments[0].leader.phone,
            }
          : undefined;

        return {
          status: 'assigned',
          voter: {
            id: voter.id,
            firstName: voter.firstName,
            lastName: voter.lastName,
            identification: voter.identification,
            gender: voter.gender,
            bloodType: voter.bloodType,
            birthDate: voter.birthDate,
            phone: voter.phone,
            address: voter.address,
            departmentId: voter.departmentId,
            municipalityId: voter.municipalityId,
            neighborhood: voter.neighborhood,
            email: voter.email,
            occupation: voter.occupation,
            votingBoothId: voter.votingBoothId,
            votingTableId: voter.votingTableId,
            politicalStatus: voter.politicalStatus,
          },
          assignedLeader: leader,
          assignedCandidates: candidates,
          message: `El votante ${voter.firstName} ${voter.lastName} ya existe y está asignado`,
        };
      }
    }

    // Step 2: If not in voters table, check voters_history
    const voterHistory = await this.votersHistoryRepository.findOne({
      where: { identification },
    });

    if (voterHistory) {
      return {
        status: 'in_history',
        votersHistoryData: {
          firstName: voterHistory.firstName,
          lastName: voterHistory.lastName,
          identification: voterHistory.identification,
          gender: voterHistory.gender,
          bloodType: voterHistory.bloodType,
          birthDate: voterHistory.birthDate,
          phone: voterHistory.phone,
          address: voterHistory.address,
          departmentId: voterHistory.departmentId,
          municipalityId: voterHistory.municipalityId,
          neighborhood: voterHistory.neighborhood,
          email: voterHistory.email,
          occupation: voterHistory.occupation,
          votingBoothId: voterHistory.votingBoothId,
          votingTableId: voterHistory.votingTableId,
          politicalStatus: voterHistory.politicalStatus,
        },
        message: `Datos encontrados en historial de votantes`,
      };
    }

    // Step 3: If not found anywhere
    return {
      status: 'not_found',
      message: `No se encontró información para la identificación ${identification}`,
    };
  }
}

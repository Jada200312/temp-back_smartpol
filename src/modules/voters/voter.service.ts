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
}

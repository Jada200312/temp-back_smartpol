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
    // Obtén el votante actual
    const voter = await this.voterRepository.findOneBy({ id });
    
    if (!voter) {
      throw new Error(`Votante con ID ${id} no encontrado`);
    }

    // Si se intenta actualizar identification, verifica que no exista en otro votante
    if (updateVoterDto.identification && updateVoterDto.identification !== voter.identification) {
      const existingIdentification = await this.voterRepository.findOneBy({
        identification: updateVoterDto.identification,
      });
      if (existingIdentification) {
        throw new Error(`La identificación ${updateVoterDto.identification} ya existe`);
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

    const candidate = await this.candidateRepository.findOneBy({ id: candidateId });

    if (!candidate) {
      throw new Error(`Candidato con ID ${candidateId} no encontrado`);
    }

    voter.candidates.push(candidate);
    return await this.voterRepository.save(voter);
  }
}
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VotingBooth } from '../../database/entities/voting-booth.entity';
import { CreateVotingBoothDto } from './dto/create-voting-booth.dto';
import { UpdateVotingBoothDto } from './dto/update-voting-booth.dto';

@Injectable()
export class VotingBoothService {
  constructor(
    @InjectRepository(VotingBooth)
    private votingBoothRepository: Repository<VotingBooth>,
  ) {}

  async create(createVotingBoothDto: CreateVotingBoothDto) {
    const votingBooth = this.votingBoothRepository.create(createVotingBoothDto);
    return await this.votingBoothRepository.save(votingBooth);
  }

  async findAll() {
    return await this.votingBoothRepository.find({
      relations: ['municipality'],
      order: { name: 'ASC' },
    });
  }

  async findByMunicipality(municipalityId: number) {
    return await this.votingBoothRepository.find({
      where: { municipalityId },
      relations: ['municipality'],
      order: { name: 'ASC' },
    });
  }

  async findOne(id: number) {
    const votingBooth = await this.votingBoothRepository.findOne({
      where: { id },
      relations: ['municipality'],
    });

    if (!votingBooth) {
      throw new NotFoundException(
        `Puesto de votación con ID ${id} no encontrado`,
      );
    }

    return votingBooth;
  }

  async update(id: number, updateVotingBoothDto: UpdateVotingBoothDto) {
    const votingBooth = await this.findOne(id);
    Object.assign(votingBooth, updateVotingBoothDto);
    return await this.votingBoothRepository.save(votingBooth);
  }

  async remove(id: number) {
    const votingBooth = await this.findOne(id);
    return await this.votingBoothRepository.remove(votingBooth);
  }
}

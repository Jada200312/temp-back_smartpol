import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VotingTable } from '../../database/entities/voting-table.entity';
import { CreateVotingTableDto } from './dto/create-voting-table.dto';
import { UpdateVotingTableDto } from './dto/update-voting-table.dto';

@Injectable()
export class VotingTableService {
  constructor(
    @InjectRepository(VotingTable)
    private votingTableRepository: Repository<VotingTable>,
  ) {}

  async create(createVotingTableDto: CreateVotingTableDto) {
    const votingTable = this.votingTableRepository.create(createVotingTableDto);
    return await this.votingTableRepository.save(votingTable);
  }

  async findAll() {
    return await this.votingTableRepository.find({
      relations: ['votingBooth', 'votingBooth.municipality'],
      order: { tableNumber: 'ASC' },
    });
  }

  async findByVotingBooth(votingBoothId: number) {
    return await this.votingTableRepository.find({
      where: { votingBoothId },
      relations: ['votingBooth'],
      order: { tableNumber: 'ASC' },
    });
  }

  async findOne(id: number) {
    const votingTable = await this.votingTableRepository.findOne({
      where: { id },
      relations: ['votingBooth', 'votingBooth.municipality'],
    });

    if (!votingTable) {
      throw new NotFoundException(`Mesa de votación con ID ${id} no encontrada`);
    }

    return votingTable;
  }

  async update(id: number, updateVotingTableDto: UpdateVotingTableDto) {
    const votingTable = await this.findOne(id);
    Object.assign(votingTable, updateVotingTableDto);
    return await this.votingTableRepository.save(votingTable);
  }

  async remove(id: number) {
    const votingTable = await this.findOne(id);
    return await this.votingTableRepository.remove(votingTable);
  }
}
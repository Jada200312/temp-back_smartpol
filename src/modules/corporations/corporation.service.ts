import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Corporation } from '../../database/entities/corporation.entity';
import { CreateCorporationDto } from './dto/create-corporation.dto';
import { UpdateCorporationDto } from './dto/update-corporation.dto';

@Injectable()
export class CorporationService {
  constructor(
    @InjectRepository(Corporation)
    private readonly corporationRepository: Repository<Corporation>,
  ) {}

  async create(createCorporationDto: CreateCorporationDto): Promise<Corporation> {
    const corporation = this.corporationRepository.create(createCorporationDto);
    return await this.corporationRepository.save(corporation);
  }

  async findAll(): Promise<Corporation[]> {
    return await this.corporationRepository.find();
  }

  async findOne(id: number): Promise<Corporation | null> {
    return await this.corporationRepository.findOneBy({ id });
  }

  async update(id: number, updateCorporationDto: UpdateCorporationDto): Promise<Corporation | null> {
    await this.corporationRepository.update(id, updateCorporationDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.corporationRepository.delete(id);
  }
}

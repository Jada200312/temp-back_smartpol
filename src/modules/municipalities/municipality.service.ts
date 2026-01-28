import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Municipality } from '../../database/entities/municipality.entity';
import { CreateMunicipalityDto } from './dto/create-municipality.dto';
import { UpdateMunicipalityDto } from './dto/update-municipality.dto';

@Injectable()
export class MunicipalityService {
  constructor(
    @InjectRepository(Municipality)
    private readonly municipalityRepository: Repository<Municipality>,
  ) {}

  async create(createMunicipalityDto: CreateMunicipalityDto): Promise<Municipality> {
    const municipality = this.municipalityRepository.create(createMunicipalityDto);
    return await this.municipalityRepository.save(municipality);
  }

  async findAll(): Promise<Municipality[]> {
    return await this.municipalityRepository.find({ relations: ['department'] });
  }

  async findOne(id: number): Promise<Municipality | null> {
    return await this.municipalityRepository.findOne({
      where: { id },
      relations: ['department'],
    });
  }

  async findByDepartment(departmentId: number): Promise<Municipality[]> {
    return await this.municipalityRepository.find({
      where: { departmentId },
      relations: ['department'],
    });
  }

  async update(id: number, updateMunicipalityDto: UpdateMunicipalityDto): Promise<Municipality | null> {
    await this.municipalityRepository.update(id, updateMunicipalityDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.municipalityRepository.delete(id);
  }
}

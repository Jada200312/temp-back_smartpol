import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Organization } from '../../database/entities/organizations.entity';
import { CreateOrganizationDto } from './dto/create-organization.dto';
import { UpdateOrganizationDto } from './dto/update-organization.dto';

@Injectable()
export class OrganizationsService {
  constructor(
    @InjectRepository(Organization)
    private organizationsRepository: Repository<Organization>,
  ) {}

  async create(createOrganizationDto: CreateOrganizationDto) {
    const organization = this.organizationsRepository.create(createOrganizationDto);
    return await this.organizationsRepository.save(organization);
  }

  async findAll() {
    return await this.organizationsRepository.find({
      relations: ['campaigns', 'users'],
    });
  }

  async findOne(id: number) {
    const organization = await this.organizationsRepository.findOne({
      where: { id },
      relations: ['campaigns', 'users'],
    });

    if (!organization) {
      throw new NotFoundException(`Organización con ID ${id} no encontrada`);
    }

    return organization;
  }

  async update(id: number, updateOrganizationDto: UpdateOrganizationDto) {
    const organization = await this.findOne(id);
    Object.assign(organization, updateOrganizationDto);
    return await this.organizationsRepository.save(organization);
  }

  async remove(id: number) {
    const organization = await this.findOne(id);
    return await this.organizationsRepository.remove(organization);
  }
}
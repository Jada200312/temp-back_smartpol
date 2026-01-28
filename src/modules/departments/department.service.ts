import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Department } from '../../database/entities/department.entity';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { UpdateDepartmentDto } from './dto/update-department.dto';

@Injectable()
export class DepartmentService {
  constructor(
    @InjectRepository(Department)
    private readonly departmentRepository: Repository<Department>,
  ) {}

  async create(createDepartmentDto: CreateDepartmentDto): Promise<Department> {
    const department = this.departmentRepository.create(createDepartmentDto);
    return await this.departmentRepository.save(department);
  }

  async findAll(): Promise<Department[]> {
    return await this.departmentRepository.find({ relations: ['municipalities'] });
  }

  async findOne(id: number): Promise<Department | null> {
    return await this.departmentRepository.findOne({
      where: { id },
      relations: ['municipalities'],
    });
  }

  async update(id: number, updateDepartmentDto: UpdateDepartmentDto): Promise<Department | null> {
    await this.departmentRepository.update(id, updateDepartmentDto);
    return await this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.departmentRepository.delete(id);
  }
}

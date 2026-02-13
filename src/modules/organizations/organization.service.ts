import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Organization } from '../../database/entities/organizations.entity';
import { User } from '../../database/entities/user.entity';
import { CreateOrganizationDto } from './dto/create-organization.dto';
import { CreateOrganizationWithAdminDto } from './dto/create-organization-with-admin.dto';
import { UpdateOrganizationDto } from './dto/update-organization.dto';

@Injectable()
export class OrganizationsService {
  constructor(
    @InjectRepository(Organization)
    private organizationsRepository: Repository<Organization>,
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async create(createOrganizationDto: CreateOrganizationDto) {
    const organization = this.organizationsRepository.create(createOrganizationDto);
    return await this.organizationsRepository.save(organization);
  }

  async createOrganizationWithAdmin(
    createOrganizationWithAdminDto: CreateOrganizationWithAdminDto,
  ) {
    const { adminEmail, adminPassword, adminRoleId, name, description } =
      createOrganizationWithAdminDto;

    console.log('Validando email:', adminEmail); // DEBUG

    // Validar que el email NO exista
    const existingUser = await this.usersRepository.findOne({
      where: { email: adminEmail.toLowerCase() },
    });

    console.log('Usuario existente:', existingUser); // DEBUG

    if (existingUser) {
      throw new BadRequestException('El email del administrador ya está registrado');
    }

    // Crear la organización
    const organization = this.organizationsRepository.create({
      name,
      description,
    });
    const savedOrganization = await this.organizationsRepository.save(organization);

    console.log('Organización creada:', savedOrganization.id); // DEBUG

    try {
      // Hash de la contraseña
      const bcrypt = require('bcrypt');
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(adminPassword, salt);

      // Crear el usuario administrador
      const adminUserData = {
        email: adminEmail.toLowerCase(),
        password: hashedPassword,
        organizationId: savedOrganization.id,
        roleId: adminRoleId,
      };

      const adminUser = this.usersRepository.create(adminUserData);
      const savedAdmin = await this.usersRepository.save(adminUser);

      console.log('Admin usuario creado:', savedAdmin.id); // DEBUG

      return {
        organization: savedOrganization,
        admin: {
          id: savedAdmin.id,
          email: savedAdmin.email,
        },
      };
    } catch (error) {
      // Si hay error al crear el usuario, elimina la organización
      await this.organizationsRepository.remove(savedOrganization);
      console.error('Error creando admin:', error);
      throw error;
    }
  }

  async findAll(
    page: number = 1,
    limit: number = 10,
    search?: string,
  ) {
    const query = this.organizationsRepository.createQueryBuilder('organization');

    if (search) {
      query.where(
        'organization.name ILIKE :search OR organization.description ILIKE :search',
        { search: `%${search}%` },
      );
    }

    const [data, total] = await query
      .leftJoinAndSelect('organization.campaigns', 'campaigns')
      .leftJoinAndSelect('organization.users', 'users')
      .skip((page - 1) * limit)
      .take(limit)
      .getManyAndCount();

    const pages = Math.ceil(total / limit);

    return {
      data,
      page,
      pages,
      total,
    };
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
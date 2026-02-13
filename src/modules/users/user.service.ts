import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from '../../database/entities/user.entity';
import { CampaignUser } from '../../database/entities/campaign-user.entity';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    @InjectRepository(CampaignUser)
    private readonly campaignUserRepository: Repository<CampaignUser>,
  ) {}

  async create(createUserDto: CreateUserDto): Promise<User> {
    const { campaignIds, ...userData } = createUserDto;
    
    // Hash la contraseña antes de guardar
    const hashedPassword = await bcrypt.hash(userData.password, 10);
    const user = this.userRepository.create({
      ...userData,
      password: hashedPassword,
    });
    const savedUser = await this.userRepository.save(user);

    if (campaignIds && campaignIds.length > 0) {
      await this.assignUserToCampaigns(savedUser.id, campaignIds);
    }

    return (await this.findOne(savedUser.id))!;
  }

  async findAll(): Promise<User[]> {
    return await this.userRepository.find({
      relations: ['campaignUsers', 'campaignUsers.campaign'],
    });
  }

  async findByRole(roleId: number): Promise<User[]> {
    return await this.userRepository.find({
      where: { roleId },
      relations: ['role', 'campaignUsers', 'campaignUsers.campaign'],
    });
  }

  async findByRoleWithPagination(
    roleId: number,
    page: number = 1,
    limit: number = 10,
    search?: string,
  ): Promise<{
    data: User[];
    total: number;
    page: number;
    limit: number;
    pages: number;
  }> {
    const skip = (page - 1) * limit;
    const query = this.userRepository
      .createQueryBuilder('user')
      .leftJoinAndSelect('user.campaignUsers', 'campaignUsers')
      .leftJoinAndSelect('campaignUsers.campaign', 'campaign')
      .where('user.roleId = :roleId', { roleId });

    if (search && search.trim()) {
      query.andWhere('LOWER(user.email) LIKE LOWER(:search)', {
        search: `%${search}%`,
      });
    }

    const [users, total] = await query.skip(skip).take(limit).getManyAndCount();

    return {
      data: users,
      total,
      page,
      limit,
      pages: Math.ceil(total / limit),
    };
  }

  async findOne(id: number): Promise<User | null> {
    return await this.userRepository.findOne({
      where: { id },
      relations: ['role', 'campaignUsers', 'campaignUsers.campaign'],
    });
  }

  async findByEmail(email: string): Promise<User | null> {
    return await this.userRepository.findOne({
      where: { email },
      relations: ['role', 'campaignUsers', 'campaignUsers.campaign'],
    });
  }

  async update(id: number, updateUserDto: UpdateUserDto): Promise<User | null> {
    const { campaignIds, ...userData } = updateUserDto;

    // Si se actualiza la contraseña, hashearla
    if (userData.password) {
      userData.password = await bcrypt.hash(userData.password, 10);
    }
    
    await this.userRepository.update(id, userData);

    if (campaignIds && campaignIds.length > 0) {
      await this.campaignUserRepository.delete({ userId: id });
      await this.assignUserToCampaigns(id, campaignIds);
    }

    return await this.findOne(id);
  }

  async updatePassword(id: number, hashedPassword: string): Promise<void> {
    await this.userRepository.update(id, { password: hashedPassword });
  }

  async remove(id: number): Promise<void> {
    await this.userRepository.delete(id);
  }

  async assignUserToCampaigns(userId: number, campaignIds: number[]) {
    const campaignUsers = campaignIds.map((campaignId) =>
      this.campaignUserRepository.create({
        userId,
        campaignId,
      }),
    );
    return await this.campaignUserRepository.save(campaignUsers);
  }

  async removeUserFromCampaign(userId: number, campaignId: number) {
    return await this.campaignUserRepository.delete({
      userId,
      campaignId,
    });
  }
}
import {
  Injectable,
  NotFoundException,
  ForbiddenException,
  BadRequestException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Campaign } from '../../database/entities/campaigns.entity';
import { CampaignUser } from '../../database/entities/campaign-user.entity';
import { User } from '../../database/entities/user.entity';
import { CreateCampaignDto } from './dto/create-campaign.dto';
import { UpdateCampaignDto } from './dto/update-campaign.dto';

@Injectable()
export class CampaignsService {
  constructor(
    @InjectRepository(Campaign)
    private campaignsRepository: Repository<Campaign>,
    @InjectRepository(CampaignUser)
    private campaignUserRepository: Repository<CampaignUser>,
  ) {}

  async create(createCampaignDto: CreateCampaignDto, currentUser: User) {
    const { userIds, organizationId, ...campaignData } = createCampaignDto;

    let finalOrganizationId: number;

    // Caso 1: Usuario es admin de organización
    // Tiene organizationId, así que la campaña se crea para su organización
    if (currentUser.organizationId) {
      finalOrganizationId = currentUser.organizationId;
    }
    // Caso 2: Usuario es super admin (no tiene organizationId)
    // DEBE proporcionar organizationId en el request
    else if (organizationId) {
      finalOrganizationId = organizationId;
    }
    // Caso 3: Usuario es super admin pero no proporciona organizationId
    else {
      throw new BadRequestException(
        'Como super admin, debes proporcionar organizationId para crear una campaña',
      );
    }

    // Crear objeto para la campaña
    const campaignPayload: any = {
      ...campaignData,
      organizationId: finalOrganizationId,
    };

    const campaign = this.campaignsRepository.create(campaignPayload);
    const savedCampaign = await this.campaignsRepository.save(campaign);

    // Asegurar que savedCampaign es un objeto, no un array
    const campaignId = Array.isArray(savedCampaign)
      ? (savedCampaign[0] as any).id
      : (savedCampaign as any).id;

    if (userIds && userIds.length > 0) {
      await this.assignUsersTooCampaign(campaignId, userIds, currentUser);
    }

    return await this.findOne(campaignId, currentUser);
  }

  async findAll(currentUser: User) {
    const query = this.campaignsRepository.createQueryBuilder('campaign');

    // Si el usuario tiene organizationId, es admin de organización
    // Solo ve campañas de su organización
    if (currentUser.organizationId) {
      query.where('campaign.organizationId = :organizationId', {
        organizationId: currentUser.organizationId,
      });
    }
    // Si no tiene organizationId, es super admin y ve TODAS las campañas

    query
      .leftJoinAndSelect('campaign.organization', 'organization')
      .leftJoinAndSelect('campaign.campaignUsers', 'campaignUsers')
      .leftJoinAndSelect('campaignUsers.user', 'user')
      .leftJoinAndSelect('campaign.candidates', 'candidates')
      .leftJoinAndSelect('campaign.leaders', 'leaders');

    return await query.getMany();
  }

  async findOne(id: number, currentUser?: User) {
    const campaign = await this.campaignsRepository.findOne({
      where: { id },
      relations: [
        'organization',
        'campaignUsers',
        'campaignUsers.user',
        'candidates',
        'leaders',
      ],
    });

    if (!campaign) {
      throw new NotFoundException(`Campaña con ID ${id} no encontrada`);
    }

    // Validar acceso si se proporciona currentUser
    if (currentUser) {
      // Si el usuario es admin de organización, solo puede ver sus campañas
      if (currentUser.organizationId) {
        if (campaign.organizationId !== currentUser.organizationId) {
          throw new ForbiddenException(
            'No tienes permiso para acceder a esta campaña',
          );
        }
      }
      // Si es super admin (no tiene organizationId), puede ver todas
    }

    return campaign;
  }

  async findByOrganization(organizationId: number, currentUser: User) {
    // Si el usuario es admin de organización
    if (currentUser.organizationId) {
      // Solo puede ver sus propias campañas
      if (organizationId !== currentUser.organizationId) {
        throw new ForbiddenException(
          'Solo puedes ver las campañas de tu organización',
        );
      }
    }
    // Si es super admin (no tiene organizationId), puede ver cualquier organización

    return await this.campaignsRepository.find({
      where: { organizationId },
      relations: [
        'organization',
        'campaignUsers',
        'campaignUsers.user',
        'candidates',
        'leaders',
      ],
    });
  }

  async update(
    id: number,
    updateCampaignDto: UpdateCampaignDto,
    currentUser: User,
  ) {
    const { userIds, ...campaignData } = updateCampaignDto;
    const campaign = await this.findOne(id, currentUser);

    Object.assign(campaign, campaignData);
    await this.campaignsRepository.save(campaign);

    if (userIds && userIds.length > 0) {
      await this.campaignUserRepository.delete({ campaignId: id });
      await this.assignUsersTooCampaign(id, userIds, currentUser);
    }

    return await this.findOne(id, currentUser);
  }

  async remove(id: number, currentUser: User) {
    const campaign = await this.findOne(id, currentUser);
    return await this.campaignsRepository.remove(campaign);
  }

  async assignUsersTooCampaign(
    campaignId: number,
    userIds: number[],
    currentUser: User,
  ) {
    // Validar que la campaña existe y el usuario tiene acceso
    const campaign = await this.findOne(campaignId, currentUser);

    const campaignUsers = userIds.map((userId) =>
      this.campaignUserRepository.create({
        campaignId,
        userId,
      }),
    );
    return await this.campaignUserRepository.save(campaignUsers);
  }

  async removeUserFromCampaign(
    campaignId: number,
    userId: number,
    currentUser: User,
  ) {
    // Validar que la campaña existe y el usuario tiene acceso
    await this.findOne(campaignId, currentUser);

    return await this.campaignUserRepository.delete({
      campaignId,
      userId,
    });
  }
}
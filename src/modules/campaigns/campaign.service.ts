import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Campaign } from '../../database/entities/campaigns.entity';
import { CampaignUser } from '../../database/entities/campaign-user.entity';
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

  async create(createCampaignDto: CreateCampaignDto) {
    const { userIds, ...campaignData } = createCampaignDto;
    const campaign = this.campaignsRepository.create(campaignData);
    const savedCampaign = await this.campaignsRepository.save(campaign);

    if (userIds && userIds.length > 0) {
      await this.assignUsersTooCampaign(savedCampaign.id, userIds);
    }

    return await this.findOne(savedCampaign.id);
  }

  async findAll() {
    return await this.campaignsRepository.find({
      relations: ['organization', 'campaignUsers', 'campaignUsers.user', 'candidates', 'leaders'],
    });
  }

  async findOne(id: number) {
    const campaign = await this.campaignsRepository.findOne({
      where: { id },
      relations: ['organization', 'campaignUsers', 'campaignUsers.user', 'candidates', 'leaders'],
    });

    if (!campaign) {
      throw new NotFoundException(`Campaña con ID ${id} no encontrada`);
    }

    return campaign;
  }

  async findByOrganization(organizationId: number) {
    return await this.campaignsRepository.find({
      where: { organizationId },
      relations: ['organization', 'campaignUsers', 'campaignUsers.user', 'candidates', 'leaders'],
    });
  }

  async update(id: number, updateCampaignDto: UpdateCampaignDto) {
    const { userIds, ...campaignData } = updateCampaignDto;
    const campaign = await this.findOne(id);
    Object.assign(campaign, campaignData);
    await this.campaignsRepository.save(campaign);

    if (userIds && userIds.length > 0) {
      await this.campaignUserRepository.delete({ campaignId: id });
      await this.assignUsersTooCampaign(id, userIds);
    }

    return await this.findOne(id);
  }

  async remove(id: number) {
    const campaign = await this.findOne(id);
    return await this.campaignsRepository.remove(campaign);
  }

  async assignUsersTooCampaign(campaignId: number, userIds: number[]) {
    const campaignUsers = userIds.map((userId) =>
      this.campaignUserRepository.create({
        campaignId,
        userId,
      }),
    );
    return await this.campaignUserRepository.save(campaignUsers);
  }

  async removeUserFromCampaign(campaignId: number, userId: number) {
    return await this.campaignUserRepository.delete({
      campaignId,
      userId,
    });
  }
}
import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiBody,
  ApiQuery,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { CampaignsService } from './campaign.service';
import { CreateCampaignDto } from './dto/create-campaign.dto';
import { UpdateCampaignDto } from './dto/update-campaign.dto';
import { Campaign } from '../../database/entities/campaigns.entity';
import { Permission } from '../../permissions/permission.decorator';

@ApiTags('Campaigns')
@Controller('campaigns')
@ApiBearerAuth('access-token')
export class CampaignsController {
  constructor(private readonly campaignsService: CampaignsService) {}

  @Post()
  @Permission('campaigns:create')
  @ApiOperation({
    summary: 'Create a new campaign',
    description:
      'Register a new political campaign with organization, dates, and optional user assignments',
  })
  @ApiBody({
    type: CreateCampaignDto,
    description: 'Campaign data',
    examples: {
      example1: {
        value: {
          name: 'Campaña Electoral 2024',
          description: 'Campaña municipal para el año 2024',
          startDate: '2024-01-15',
          endDate: '2024-12-31',
          organizationId: 1,
          userIds: [1, 2, 3],
        },
        description: 'Example of creating a campaign with user assignments',
      },
      example2: {
        value: {
          name: 'Campaña Presidencial 2024',
          description: 'Campaña presidencial',
          startDate: '2024-06-01',
          endDate: '2024-08-15',
          organizationId: 1,
        },
        description: 'Example of creating a campaign without user assignments',
      },
    },
  })
  @ApiResponse({
    status: 201,
    description: 'Campaign created successfully',
    schema: {
      example: {
        id: 1,
        name: 'Campaña Electoral 2024',
        description: 'Campaña municipal para el año 2024',
        startDate: '2024-01-15',
        endDate: '2024-12-31',
        status: true,
        organizationId: 1,
        organization: {
          id: 1,
          name: 'Organización A',
        },
        candidates: [],
        leaders: [],
        campaignUsers: [
          {
            id: 1,
            campaignId: 1,
            userId: 1,
            user: {
              id: 1,
              name: 'Juan Pérez',
              email: 'juan@example.com',
            },
          },
        ],
        createdAt: '2026-02-06T12:00:00Z',
        updatedAt: '2026-02-06T12:00:00Z',
      },
    },
  })
  @ApiResponse({ status: 400, description: 'Invalid data' })
  create(@Body() createCampaignDto: CreateCampaignDto) {
    return this.campaignsService.create(createCampaignDto);
  }

  @Get()
  @Permission('campaigns:read')
  @ApiOperation({
    summary: 'Get all campaigns',
    description:
      'Returns a list of all campaigns with their associated organizations, candidates, leaders, and users',
  })
  @ApiQuery({
    name: 'page',
    type: 'number',
    required: false,
    description: 'Page number (starts at 1)',
    example: 1,
  })
  @ApiQuery({
    name: 'limit',
    type: 'number',
    required: false,
    description: 'Items per page',
    example: 10,
  })
  @ApiResponse({
    status: 200,
    description: 'List of campaigns',
    schema: {
      example: [
        {
          id: 1,
          name: 'Campaña Electoral 2024',
          description: 'Campaña municipal para el año 2024',
          startDate: '2024-01-15',
          endDate: '2024-12-31',
          status: true,
          organizationId: 1,
          organization: {
            id: 1,
            name: 'Organización A',
          },
          candidates: [
            {
              id: 1,
              name: 'Juan Duarte',
              party: 'Partido Colombiano',
              number: 1,
            },
          ],
          leaders: [
            {
              id: 1,
              name: 'Juan López',
              document: '12345678',
              municipality: 'Bogotá',
            },
          ],
          campaignUsers: [
            {
              id: 1,
              userId: 1,
              user: {
                id: 1,
                name: 'Juan Pérez',
              },
            },
          ],
          createdAt: '2026-02-06T12:00:00Z',
          updatedAt: '2026-02-06T12:00:00Z',
        },
      ],
    },
  })
  findAll(
    @Query('page') page: string = '1',
    @Query('limit') limit: string = '10',
  ) {
    return this.campaignsService.findAll();
  }

  @Get('organization/:organizationId')
  @Permission('campaigns:read')
  @ApiParam({
    name: 'organizationId',
    type: 'number',
    description: 'Organization ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get campaigns by organization',
    description: 'Returns all campaigns for a specific organization',
  })
  @ApiResponse({
    status: 200,
    description: 'Campaigns of the organization',
    schema: {
      example: [
        {
          id: 1,
          name: 'Campaña Electoral 2024',
          description: 'Campaña municipal para el año 2024',
          startDate: '2024-01-15',
          endDate: '2024-12-31',
          status: true,
          organizationId: 1,
          candidates: [],
          leaders: [],
          campaignUsers: [],
          createdAt: '2026-02-06T12:00:00Z',
          updatedAt: '2026-02-06T12:00:00Z',
        },
      ],
    },
  })
  findByOrganization(@Param('organizationId') organizationId: string) {
    return this.campaignsService.findByOrganization(+organizationId);
  }

  @Get(':id')
  @Permission('campaigns:read')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get campaign by ID',
    description:
      'Returns a specific campaign with all associated candidates, leaders, and users',
  })
  @ApiResponse({
    status: 200,
    description: 'Campaign found',
    schema: {
      example: {
        id: 1,
        name: 'Campaña Electoral 2024',
        description: 'Campaña municipal para el año 2024',
        startDate: '2024-01-15',
        endDate: '2024-12-31',
        status: true,
        organizationId: 1,
        organization: {
          id: 1,
          name: 'Organización A',
        },
        candidates: [
          {
            id: 1,
            name: 'Juan Duarte',
            party: 'Partido Colombiano',
            number: 1,
            corporation_id: 1,
          },
          {
            id: 2,
            name: 'María García',
            party: 'Partido Liberal',
            number: 2,
            corporation_id: 1,
          },
        ],
        leaders: [
          {
            id: 1,
            name: 'Juan López',
            document: '12345678',
            municipality: 'Bogotá',
            phone: '+57 312 123 4567',
          },
          {
            id: 2,
            name: 'María Rodríguez',
            document: '87654321',
            municipality: 'Medellín',
            phone: '+57 312 987 6543',
          },
        ],
        campaignUsers: [
          {
            id: 1,
            campaignId: 1,
            userId: 1,
            user: {
              id: 1,
              name: 'Juan Pérez',
              email: 'juan@example.com',
            },
          },
        ],
        createdAt: '2026-02-06T12:00:00Z',
        updatedAt: '2026-02-06T12:00:00Z',
      },
    },
  })
  @ApiResponse({ status: 404, description: 'Campaign not found' })
  findOne(@Param('id') id: string) {
    return this.campaignsService.findOne(+id);
  }

  @Patch(':id')
  @Permission('campaigns:update')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Update a campaign',
    description:
      'Update campaign information including name, description, dates, and user assignments',
  })
  @ApiBody({
    type: UpdateCampaignDto,
    description: 'Campaign data to update',
    examples: {
      example1: {
        value: {
          name: 'Campaña Electoral 2024 - Actualizada',
        },
        description: 'Update only campaign name',
      },
      example2: {
        value: {
          name: 'Campaña Electoral 2024 - Actualizada',
          description: 'Nueva descripción',
          ended: '2024-11-30',
          userIds: [1, 2, 3, 4],
        },
        description: 'Update campaign with new user assignments',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'Campaign updated successfully',
    schema: {
      example: {
        id: 1,
        name: 'Campaña Electoral 2024 - Actualizada',
        description: 'Nueva descripción',
        startDate: '2024-01-15',
        endDate: '2024-11-30',
        status: true,
        organizationId: 1,
        candidates: [],
        leaders: [],
        campaignUsers: [
          {
            id: 1,
            campaignId: 1,
            userId: 1,
          },
          {
            id: 2,
            campaignId: 1,
            userId: 2,
          },
        ],
        createdAt: '2026-02-06T12:00:00Z',
        updatedAt: '2026-02-06T13:00:00Z',
      },
    },
  })
  @ApiResponse({ status: 404, description: 'Campaign not found' })
  update(
    @Param('id') id: string,
    @Body() updateCampaignDto: UpdateCampaignDto,
  ) {
    return this.campaignsService.update(+id, updateCampaignDto);
  }

  @Delete(':id')
  @Permission('campaigns:delete')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Delete a campaign',
    description: 'Delete a campaign from the system',
  })
  @ApiResponse({ status: 200, description: 'Campaign deleted successfully' })
  @ApiResponse({ status: 404, description: 'Campaign not found' })
  remove(@Param('id') id: string) {
    return this.campaignsService.remove(+id);
  }

  @Post(':campaignId/users/:userId')
  @Permission('campaigns:update')
  @ApiParam({
    name: 'campaignId',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiParam({
    name: 'userId',
    type: 'number',
    description: 'User ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Assign user to campaign',
    description: 'Assigns a user to work in a specific campaign',
  })
  @ApiResponse({
    status: 201,
    description: 'User assigned to campaign successfully',
    schema: {
      example: {
        id: 1,
        campaignId: 1,
        userId: 1,
        user: {
          id: 1,
          name: 'Juan Pérez',
          email: 'juan@example.com',
        },
      },
    },
  })
  assignUserToCampaign(
    @Param('campaignId') campaignId: string,
    @Param('userId') userId: string,
  ) {
    return this.campaignsService.assignUsersTooCampaign(+campaignId, [+userId]);
  }

  @Delete(':campaignId/users/:userId')
  @Permission('campaigns:update')
  @ApiParam({
    name: 'campaignId',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiParam({
    name: 'userId',
    type: 'number',
    description: 'User ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Remove user from campaign',
    description: 'Removes a user from a campaign',
  })
  @ApiResponse({
    status: 200,
    description: 'User removed from campaign successfully',
  })
  @ApiResponse({ status: 404, description: 'Campaign or user not found' })
  removeUserFromCampaign(
    @Param('campaignId') campaignId: string,
    @Param('userId') userId: string,
  ) {
    return this.campaignsService.removeUserFromCampaign(+campaignId, +userId);
  }

  @Get(':id/candidates')
  @Permission('campaigns:read')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get candidates of a campaign',
    description: 'Returns all candidates registered in a specific campaign',
  })
  @ApiResponse({
    status: 200,
    description: 'List of candidates in the campaign',
    schema: {
      example: [
        {
          id: 1,
          name: 'Juan Duarte',
          party: 'Partido Colombiano',
          number: 1,
          corporation_id: 1,
        },
      ],
    },
  })
  async getCandidates(@Param('id') id: string) {
    const campaign = await this.campaignsService.findOne(+id);
    return campaign.candidates || [];
  }

  @Get(':id/leaders')
  @Permission('campaigns:read')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get leaders of a campaign',
    description: 'Returns all leaders working in a specific campaign',
  })
  @ApiResponse({
    status: 200,
    description: 'List of leaders in the campaign',
    schema: {
      example: [
        {
          id: 1,
          name: 'Juan López',
          document: '12345678',
          municipality: 'Bogotá',
          phone: '+57 312 123 4567',
        },
      ],
    },
  })
  async getLeaders(@Param('id') id: string) {
    const campaign = await this.campaignsService.findOne(+id);
    return campaign.leaders || [];
  }
}
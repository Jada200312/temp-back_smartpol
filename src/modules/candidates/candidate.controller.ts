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
} from '@nestjs/swagger';
import { CandidateService } from './candidate.service';
import { CreateCandidateDto } from './dto/create-candidate.dto';
import { UpdateCandidateDto } from './dto/update-candidate.dto';
import { Candidate } from '../../database/entities/candidate.entity';
import { Permission } from '../../permissions/permission.decorator';

@ApiTags('Candidates')
@Controller('candidates')
export class CandidateController {
  constructor(private readonly candidateService: CandidateService) {}

  @Post()
  @Permission('candidates:create')
  @ApiOperation({
    summary: 'Create a new candidate',
    description: 'Register a new political candidate in the system',
  })
  @ApiBody({
    type: CreateCandidateDto,
    description: 'Candidate data',
    examples: {
      example1: {
        value: {
          name: 'Juan Duarte',
          party: 'Partido Colombiano',
          number: 1,
          corporation_id: 1,
          campaignId: 1,
        },
        description: 'Example of creating a candidate',
      },
    },
  })
  @ApiResponse({
    status: 201,
    description: 'Candidate created successfully',
    schema: {
      example: {
        id: 1,
        name: 'Juan Duarte',
        party: 'Partido Colombiano',
        number: 1,
        corporation_id: 1,
        campaignId: 1,
        campaign: {
          id: 1,
          name: 'Campaign A',
          startDate: '2024-01-01',
          endDate: '2024-12-31',
        },
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  async create(
    @Body() createCandidateDto: CreateCandidateDto,
  ): Promise<Candidate> {
    return await this.candidateService.create(createCandidateDto);
  }

  @Get()
  @Permission('candidates:read')
  @ApiOperation({
    summary: 'Get all candidates',
    description:
      'Returns the complete list of registered candidates with pagination and search support',
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
  @ApiQuery({
    name: 'search',
    type: 'string',
    required: false,
    description: 'Search by name, party or number (case-insensitive)',
  })
  @ApiResponse({
    status: 200,
    description: 'List of candidates retrieved successfully',
    schema: {
      example: {
        data: [
          {
            id: 1,
            name: 'Juan Duarte',
            party: 'Partido Colombiano',
            number: 1,
            corporation_id: 1,
            campaignId: 1,
            campaign: {
              id: 1,
              name: 'Campaign A',
            },
            createdAt: '2024-01-27T10:30:00Z',
            updatedAt: '2024-01-27T10:30:00Z',
          }
        ],
        total: 1,
        page: 1,
        limit: 10,
        pages: 1,
      },
    },
  })
  async findAll(
    @Query('page') page: string = '1',
    @Query('limit') limit: string = '10',
    @Query('search') search?: string,
  ) {
    const pageNum = Math.max(1, parseInt(page, 10) || 1);
    const limitNum = Math.max(1, parseInt(limit, 10) || 10);
    return await this.candidateService.findAllWithPagination(
      pageNum,
      limitNum,
      search,
    );
  }

  @Get('by-campaign/:campaignId')
  @Permission('candidates:read')
  @ApiParam({
    name: 'campaignId',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get candidates by campaign ID',
    description: 'Returns all candidates associated with a specific campaign',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidates found for the campaign',
    schema: {
      example: [
        {
          id: 1,
          name: 'Juan Duarte',
          party: 'Partido Colombiano',
          number: 1,
          corporation_id: 1,
          campaignId: 1,
          campaign: {
            id: 1,
            name: 'Campaign A',
            startDate: '2024-01-01',
            endDate: '2024-12-31',
            status: true,
          },
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z',
        },
        {
          id: 2,
          name: 'María García',
          party: 'Partido Liberal',
          number: 2,
          corporation_id: 1,
          campaignId: 1,
          campaign: {
            id: 1,
            name: 'Campaña 2024',
            startDate: '2024-01-15',
            endDate: '2024-12-31',
            status: true,
          },
          createdAt: '2026-02-06T02:10:14Z',
          updatedAt: '2026-02-06T02:10:14Z',
        },
      ],
    },
  })

  @ApiResponse({
    status: 200,
    description: 'No candidates found for the campaign',
    schema: {
      example: [],
    },
  })
  async findByCampaignId(
    @Param('campaignId') campaignId: string,
  ): Promise<Candidate[]> {
    return await this.candidateService.findByCampaignIds([+campaignId]);
  }

  @Get(':id')
  @Permission('candidates:read')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Candidate ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get candidate by ID',
    description: 'Returns a specific candidate',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidate found',
    schema: {
      example: {
        id: 1,
        name: 'Juan Duarte',
        party: 'Partido Colombiano',
        number: 1,
        corporation_id: 1,
        userId: null,
        campaignId: 1,
        Campaign:{
          id: 1,
          name: 'Campaign A',
          startDate: '2024-01-01',
          endDate: '2024-12-31',
          status: true,
        },
        leaders: [],
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Candidate not found',
  })

  async findOne(@Param('id') id: string): Promise<Candidate | null> {
    return await this.candidateService.findOne(+id);
  }

  @Get('by-user/:userId')
  @Permission('candidates:read')
  @ApiParam({
    name: 'userId',
    type: 'number',
    description: 'User ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get candidate by user ID',
    description: 'Returns the candidate associated with a specific user',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidate found',
    schema: {
      example: {
        id: 1,
        name: 'Juan Duarte',
        party: 'Partido Colombiano',
        number: 1,
        corporation_id: 1,
        userId: 1,
        campaignId: 1,
        campaign: {
          id: 1,
          name: 'Campaign A',
          startDate: '2024-01-01',
        },
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Candidate not found for this user',
  })
  async findByUserId(
    @Param('userId') userId: string,
  ): Promise<Candidate | null> {
    return await this.candidateService.findByUserId(+userId);
  }

  @Patch(':id')
  @Permission('candidates:update')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Candidate ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Update a candidate',
    description: 'Update candidate information including campaign assignment',
  })
  @ApiBody({
    type: UpdateCandidateDto,
    description: 'Candidate data to update',
    examples: {
      example1: {
        value: {
          name: 'Juan Duarte Updated',
        },
        description: 'Update only candidate name',
      },
      example2: {
        value: {
          campaignId: 2,
        },
        description: 'Change campaign assignment',
      },
      example3: {
        value: {
          CampaignId: null,
        },
        description: 'Update multiple fields including campaign',
      },
      example4: {
        value: {
          name: 'Juan Duarte',
          party: 'Partido Conservador',
          campaignId: 1,
        },
        description: 'Update multiple fields including campaign',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'Candidate updated successfully',
    schema: {
      example: {
        id: 1,
        name: 'Juan Duarte Updated',
        party: 'Partido Colombiano',
        number: 1,
        corporation_id: 1,
        userId: null,
        campaignId: 2,
        Campaign: {
          id: 2,
          name: 'Campaign B',
          startDate: '2026-01-01',
          endDate: '2026-12-31',
        },
        createdAt: '2026-02-06T02:10:14Z',
        updatedAt: '2026-02-06T02:15:30Z',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Candidate not found',
  })
  async update(
    @Param('id') id: string,
    @Body() updateCandidateDto: UpdateCandidateDto,
  ): Promise<Candidate | null> {
    return await this.candidateService.update(+id, updateCandidateDto);
  }

  @Delete(':id')
  @Permission('candidates:delete')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Candidate ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Delete a candidate',
    description: 'Delete a candidate from the system',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidate deleted successfully',
  })
  @ApiResponse({
    status: 404,
    description: 'Candidate not found',
  })
  async remove(@Param('id') id: string): Promise<void> {
    return await this.candidateService.remove(+id);
  }

  @Post(':candidateId/leaders/:leaderId')
  @Permission('candidates:update')
  @ApiParam({
    name: 'candidateId',
    type: 'number',
    description: 'Candidate ID',
    example: 1,
  })
  @ApiParam({
    name: 'leaderId',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Assign a leader to a candidate',
    description: 'Assigns a political leader to a candidate',
  })
  @ApiResponse({
    status: 201,
    description: 'Leader assigned successfully to candidate',
    schema: {
      example: {
        id: 1,
        name: 'Juan Duarte',
        party: 'Partido Colombiano',
        number: 1,
        corporation_id: 1,
        campaignId: 1,
        leaders: [
          {
            id: 1,
            name: 'HELMAR MENDOZA',
            document: '1888116',
            municipality: 'OVEJAS',
            phone: '3103814496',
          },
        ],
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Candidate or Leader not found',
  })
  async assignLeaderToCandidate(
    @Param('candidateId') candidateId: string,
    @Param('leaderId') leaderId: string,
  ): Promise<Candidate> {
    return await this.candidateService.assignLeaderToCandidate(
      +candidateId,
      +leaderId,
    );
  }

  @Delete(':candidateId/leaders/:leaderId')
  @Permission('candidates:update')
  @ApiParam({
    name: 'candidateId',
    type: 'number',
    description: 'Candidate ID',
    example: 1,
  })
  @ApiParam({
    name: 'leaderId',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Remove a leader from a candidate',
    description: 'Removes the assignment of a leader from a candidate',
  })
  @ApiResponse({
    status: 200,
    description: 'Leader removed successfully from candidate',
  })
  @ApiResponse({
    status: 404,
    description: 'Candidate or Leader not found',
  })
  async removeLeaderFromCandidate(
    @Param('candidateId') candidateId: string,
    @Param('leaderId') leaderId: string,
  ): Promise<Candidate> {
    return await this.candidateService.removeLeaderFromCandidate(
      +candidateId,
      +leaderId,
    );
  }

  @Get(':candidateId/leaders')
  @Permission('candidates:read')
  @ApiParam({
    name: 'candidateId',
    type: 'number',
    description: 'Candidate ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get all leaders of a candidate',
    description: 'Returns all leaders assigned to a specific candidate',
  })
  @ApiResponse({
    status: 200,
    description: 'Leaders retrieved successfully',
    schema: {
      example: [
        {
          id: 1,
          name: 'HELMAR MENDOZA',
          document: '1888116',
          municipality: 'OVEJAS',
          phone: '3103814496',
        },
      ],
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Candidate not found',
  })
  async getLeadersByCandidate(@Param('candidateId') candidateId: string) {
    return await this.candidateService.getLeadersByCandidate(+candidateId);
  }

  @Get('filter/leader/:leaderId/corporation/:corporationId')
  @Permission('candidates:read')
  @ApiParam({
    name: 'leaderId',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiParam({
    name: 'corporationId',
    type: 'number',
    description: 'Corporation ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get candidates by leader and corporation',
    description:
      'Returns all candidates associated with a specific leader and corporation',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidates found',
    schema: {
      example: [
        {
          id: 1,
          name: 'Juan Duarte',
          party: 'Partido Colombiano',
          number: 1,
          corporation_id: 1,
          campaignId: 1,
          campaign: {
            id: 1,
            name: 'Campaign A',
          },
          corporation: {
            id: 1,
            name: 'Corporation A',
          },
          leaders: [
            {
              id: 1,
              name: 'HELMAR MENDOZA',
              document: '1888116',
              municipality: 'OVEJAS',
              phone: '3103814496',
            },
          ],
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z',
        },
      ],
    },
  })
  @ApiResponse({
    status: 404,
    description: 'No candidates found',
  })
  async findByLeaderAndCorporation(
    @Param('leaderId') leaderId: number,
    @Param('corporationId') corporationId: number,
  ): Promise<Candidate[]> {
    return await this.candidateService.findByLeaderAndCorporation(
      leaderId,
      corporationId,
    );
  }
}

import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  Request,
  BadRequestException,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiBody,
  ApiQuery,
} from '@nestjs/swagger';
import { LeaderService } from './leader.service';
import { CreateLeaderDto } from './dto/create-leader.dto';
import { UpdateLeaderDto } from './dto/update-leader.dto';
import { Leader } from '../../database/entities/leader.entity';
import { Candidate } from '../../database/entities/candidate.entity';
import { Permission } from '../../permissions/permission.decorator';

@ApiTags('Leaders')
@Controller('leaders')
export class LeaderController {
  constructor(private readonly leaderService: LeaderService) {}

  @Post()
  @Permission('leaders:create')
  @ApiOperation({
    summary: 'Create a new leader',
    description:
      'Register a new political leader in the system with optional campaign assignment',
  })
  @ApiBody({
    type: CreateLeaderDto,
    description: 'Leader data',
    examples: {
      example1: {
        value: {
          name: 'Juan López',
          document: '12345678',
          municipality: 'Bogotá',
          phone: '+57 312 123 4567',
          campaignIds: 1,
        },
        description: 'Example of creating a leader with campaign assignment',
      },
      example2: {
        value: {
          name: 'María Rodríguez',
          document: '87654321',
          municipality: 'Medellín',
          phone: '+57 312 987 6543',
        },
        description: 'Example of creating a leader without campaign assignment',
      },
    },
  })
  @ApiResponse({
    status: 201,
    description: 'Leader created successfully',
    schema: {
      example: {
        id: 1,
        name: 'Juan López',
        document: '12345678',
        municipality: 'Bogotá',
        phone: '+57 312 123 4567',
        userId: null,
        campaignIds: 1,
        Campaign: {
          id: 1,
          name: 'Campaña de Prueba',
          startDate: '2024-01-01T00:00:00Z',
          endDate: '2024-12-31T23:59:59Z',
          status: 'active',
        },
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  async create(
    @Body() createLeaderDto: CreateLeaderDto,
    @Request() req: any,
  ): Promise<Leader> {
    return await this.leaderService.create(createLeaderDto, req.user);
  }

  @Get()
  @Permission('leaders:read')
  @ApiOperation({
    summary: 'Get all leaders',
    description:
      'Returns the complete list of registered leaders with pagination and search support',
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
    description: 'Search by name, document or municipality (case-insensitive)',
  })
  @ApiResponse({
    status: 200,
    description: 'List of leaders retrieved successfully',
    schema: {
      example: {
        data: [
          {
            id: 1,
            name: 'Juan López',
            document: '12345678',
            municipality: 'Bogotá',
            phone: '+57 312 123 4567',
            campaignId: 1,
            campaign: {
              id: 1,
              name: 'Campaña de Prueba',
              startDate: '2024-01-01T00:00:00Z',
              endDate: '2024-12-31T23:59:59Z',
            },
            createdAt: '2024-01-27T10:30:00Z',
            updatedAt: '2024-01-27T10:30:00Z',
          },
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
    return await this.leaderService.findAllWithPagination(
      pageNum,
      limitNum,
      search,
    );
  }

  // ✅ RUTA 1: Por campaña (para admin/coordinador) - SIN paginación
  @Get('by-campaign/:campaignId')
  @Permission('leaders:read')
  @ApiParam({
    name: 'campaignId',
    type: 'number',
    description: 'Campaign ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get leaders by campaign ID',
    description: 'Returns all leaders working for a specific campaign',
  })
  @ApiResponse({
    status: 200,
    description: 'Leaders found for the campaign',
    schema: {
      example: [
        {
          id: 1,
          name: 'Juan López',
          document: '12345678',
          municipality: 'Bogotá',
          phone: '+57 312 123 4567',
          campaignId: 1,
          campaign: {
            id: 1,
            name: 'Campaña de Prueba',
            startDate: '2024-01-01T00:00:00Z',
            endDate: '2024-12-31T23:59:59Z',
            status: 'active',
          },
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z',
        },
      ],
    },
  })
  @ApiResponse({
    status: 200,
    description: 'No leaders found for this campaign',
    schema: {
      example: [],
    },
  })
  async findByCampaignId(
    @Param('campaignId') campaignId: string,
  ): Promise<Leader[]> {
    const id = parseInt(campaignId, 10);
    if (isNaN(id) || id <= 0) {
      throw new BadRequestException('campaignId debe ser un número válido');
    }
    return await this.leaderService.findByCampaignId(id);
  }

  // ✅ RUTA 2: Por candidato (para candidatos) - CON paginación
  @Get('by-candidate/:candidateId')
  @Permission('leaders:read')
  @ApiParam({
    name: 'candidateId',
    type: 'number',
    description: 'Candidate ID',
    example: 1,
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
    description: 'Search by name, document or municipality (case-insensitive)',
  })
  @ApiOperation({
    summary: 'Get leaders by candidate with pagination',
    description:
      'Returns a paginated list of leaders associated with a specific candidate',
  })
  @ApiResponse({
    status: 200,
    description: 'List of leaders for the candidate retrieved successfully',
    schema: {
      example: {
        data: [
          {
            id: 1,
            name: 'Juan López',
            document: '12345678',
            municipality: 'Bogotá',
            campaignId: 1,
            campaign: {
              id: 1,
              name: 'Campaña de Prueba',
            },
          },
        ],
        total: 1,
        page: 1,
        limit: 10,
        pages: 1,
      },
    },
  })
  async findByCandidate(
    @Param('candidateId') candidateId: string,
    @Query('page') page: string = '1',
    @Query('limit') limit: string = '10',
    @Query('search') search?: string,
  ) {
    const id = parseInt(candidateId, 10);
    const pageNum = Math.max(1, parseInt(page, 10) || 1);
    const limitNum = Math.max(1, parseInt(limit, 10) || 10);

    if (isNaN(id) || id <= 0) {
      throw new BadRequestException('candidateId debe ser un número válido');
    }

    console.log('📞 Buscando líderes para candidato:', { id, pageNum, limitNum });

    return await this.leaderService.findByCandidateWithPagination(
      id,
      pageNum,
      limitNum,
      search,
    );
  }

  @Get('by-user/:userId')
  @ApiParam({
    name: 'userId',
    type: 'number',
    description: 'User ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get leader by user ID',
    description: 'Returns the leader associated with a specific user',
  })
  @ApiResponse({
    status: 200,
    description: 'Leader found successfully',
    schema: {
      example: {
        id: 1,
        name: 'Juan López',
        document: '12345678',
        municipality: 'Bogotá',
        phone: '+57 312 123 4567',
        userId: 5,
        campaignId: 1,
        Campaign: {
          id: 1,
          name: 'Campaña de Prueba',
        },
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Leader not found for the given user ID',
  })
  async findByUserId(@Param('userId') userId: string): Promise<Leader | null> {
    return await this.leaderService.findByUserId(+userId);
  }

  @Get(':id')
  @Permission('leaders:read')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get leader by ID',
    description:
      'Returns a specific leader with all its relationships including assigned campaign and candidates',
  })
  @ApiResponse({
    status: 200,
    description: 'Leader found',
    schema: {
      example: {
        id: 1,
        name: 'Juan López',
        document: '12345678',
        municipality: 'Bogotá',
        phone: '+57 312 123 4567',
        userId: null,
        campaignId: 1,
        Campaign: {
          id: 1,
          name: 'Campaña de Prueba',
          startDate: '2024-01-01T00:00:00Z',
          endDate: '2024-12-31T23:59:59Z',
          status: 'active',
        },
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Leader not found',
  })
  async findOne(@Param('id') id: string): Promise<Leader | null> {
    return await this.leaderService.findOne(+id);
  }

  @Patch(':id')
  @Permission('leaders:update')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Update a leader',
    description: 'Update leader information',
  })
  @ApiBody({
    type: UpdateLeaderDto,
    description: 'Leader data to update',
    examples: {
      example1: {
        value: {
          phone: '+57 312 999 8888',
        },
        description: 'Example of updating leader phone',
      },
      example2: {
        value: {
          campaignId: 2,
        },
        description: 'Example of updating leader campaign assignment',
      },
      example3: {
        value: {
          name: 'Juan López Updated',
          municipality: 'Cali',
          campaignId: 1,
        },
        description: 'Update multiple fields including campaign',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'Leader updated successfully',
    schema: {
      example: {
        id: 1,
        name: 'Juan López',
        document: '12345678',
        municipality: 'Bogotá',
        phone: '+57 312 999 8888',
        campaignId: 1,
        campaign: {
          id: 1,
          name: 'Campaña de Prueba',
        },
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:01Z',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Leader not found',
  })
  async update(
    @Param('id') id: string,
    @Body() updateLeaderDto: UpdateLeaderDto,
  ): Promise<Leader | null> {
    return await this.leaderService.update(+id, updateLeaderDto);
  }

  @Delete(':id')
  @Permission('leaders:delete')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Delete a leader',
    description:
      'Delete a leader from the system. Also deletes associated user if exists',
  })
  @ApiResponse({
    status: 200,
    description: 'Leader deleted successfully',
  })
  @ApiResponse({
    status: 404,
    description: 'Leader not found',
  })
  async remove(@Param('id') id: string): Promise<void> {
    return await this.leaderService.remove(+id);
  }

  @Get(':id/candidates')
  @Permission('leaders:read')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get candidates of a leader',
    description: 'Returns all candidates associated with a specific leader',
  })
  @ApiResponse({
    status: 200,
    description: 'List of candidates retrieved successfully',
    schema: {
      example: [
        {
          id: 1,
          name: 'Juan Duarte',
          party: 'Partido Colombiano',
          number: 1,
          corporation_id: 1,
          campaignId: 1,
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z',
        },
      ],
    },
  })
  @ApiResponse({
    status: 404,
    description: 'Leader not found',
  })
  async getCandidates(@Param('id') id: string): Promise<Candidate[]> {
    return await this.leaderService.getCandidates(+id);
  }

  @Post(':id/assign-candidates')
  @Permission('leaders:update')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        candidateIds: {
          type: 'array',
          items: { type: 'number' },
          example: [1, 2, 3],
          description: 'Array of candidate IDs to assign',
        },
      },
      required: ['candidateIds'],
    },
  })
  @ApiOperation({
    summary: 'Assign candidates to a leader',
    description:
      'Replaces all candidates assigned to a leader with the provided list',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidates assigned successfully',
  })
  @ApiResponse({
    status: 404,
    description: 'Leader not found',
  })
  async assignCandidates(
    @Param('id') id: string,
    @Body() body: { candidateIds: number[] },
  ): Promise<Leader> {
    return await this.leaderService.assignCandidates(+id, body.candidateIds);
  }

  @Post(':id/add-candidates')
  @Permission('leaders:update')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        candidateIds: {
          type: 'array',
          items: { type: 'number' },
          example: [1, 2, 3],
          description: 'Array of candidate IDs to add',
        },
      },
      required: ['candidateIds'],
    },
  })
  @ApiOperation({
    summary: 'Add candidates to a leader',
    description: 'Adds candidates to a leader without removing existing ones',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidates added successfully',
  })
  async addCandidates(
    @Param('id') id: string,
    @Body() body: { candidateIds: number[] },
  ): Promise<Leader> {
    return await this.leaderService.addCandidates(+id, body.candidateIds);
  }

  @Post(':id/remove-candidates')
  @Permission('leaders:update')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1,
  })
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        candidateIds: {
          type: 'array',
          items: { type: 'number' },
          example: [1, 2, 3],
          description: 'Array of candidate IDs to remove',
        },
      },
      required: ['candidateIds'],
    },
  })
  @ApiOperation({
    summary: 'Remove candidates from a leader',
    description: 'Removes specific candidates from a leader',
  })
  @ApiResponse({
    status: 200,
    description: 'Candidates removed successfully',
  })
  async removeCandidates(
    @Param('id') id: string,
    @Body() body: { candidateIds: number[] },
  ): Promise<Leader> {
    return await this.leaderService.removeCandidates(+id, body.candidateIds);
  }
}
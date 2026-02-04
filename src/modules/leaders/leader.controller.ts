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
    description: 'Register a new political leader in the system',
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
        },
        description: 'Example of creating a leader',
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
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  async create(@Body() createLeaderDto: CreateLeaderDto): Promise<Leader> {
    return await this.leaderService.create(createLeaderDto);
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
    description: 'Returns a specific leader',
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
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
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
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:01Z',
      },
    },
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
    description: 'Delete a leader from the system',
  })
  @ApiResponse({
    status: 200,
    description: 'Leader deleted successfully',
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

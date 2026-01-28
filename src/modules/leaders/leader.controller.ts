import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { 
  ApiTags, 
  ApiOperation, 
  ApiResponse, 
  ApiParam,
  ApiBody
} from '@nestjs/swagger';
import { LeaderService } from './leader.service';
import { CreateLeaderDto } from './dto/create-leader.dto';
import { UpdateLeaderDto } from './dto/update-leader.dto';
import { Leader } from '../../database/entities/leader.entity';
import { Candidate } from '../../database/entities/candidate.entity';

@ApiTags('Leaders')
@Controller('leaders')
export class LeaderController {
  constructor(private readonly leaderService: LeaderService) {}

  @Post()
  @ApiOperation({ 
    summary: 'Create a new leader',
    description: 'Register a new political leader in the system'
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
          phone: '+57 312 123 4567'
        },
        description: 'Example of creating a leader'
      }
    }
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
        updatedAt: '2024-01-27T10:30:00Z'
      }
    }
  })
  async create(@Body() createLeaderDto: CreateLeaderDto): Promise<Leader> {
    return await this.leaderService.create(createLeaderDto);
  }

  @Get()
  @ApiOperation({ 
    summary: 'Get all leaders',
    description: 'Returns the complete list of registered leaders'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'List of leaders retrieved successfully',
    schema: {
      example: [
        {
          id: 1,
          name: 'Juan López',
          document: '12345678',
          municipality: 'Bogotá',
          phone: '+57 312 123 4567',
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z'
        }
      ]
    }
  })
  async findAll(): Promise<Leader[]> {
    return await this.leaderService.findAll();
  }

  @Get(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Get leader by ID',
    description: 'Returns a specific leader'
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
        updatedAt: '2024-01-27T10:30:00Z'
      }
    }
  })
  async findOne(@Param('id') id: string): Promise<Leader | null> {
    return await this.leaderService.findOne(+id);
  }

  @Patch(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Update a leader',
    description: 'Update leader information'
  })
  @ApiBody({
    type: UpdateLeaderDto,
    description: 'Leader data to update',
    examples: {
      example1: {
        value: {
          phone: '+57 312 999 8888'
        },
        description: 'Example of updating leader phone'
      }
    }
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
        updatedAt: '2024-01-27T10:30:01Z'
      }
    }
  })
  async update(
    @Param('id') id: string,
    @Body() updateLeaderDto: UpdateLeaderDto,
  ): Promise<Leader | null> {
    return await this.leaderService.update(+id, updateLeaderDto);
  }

  @Delete(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Delete a leader',
    description: 'Delete a leader from the system'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'Leader deleted successfully'
  })
  async remove(@Param('id') id: string): Promise<void> {
    return await this.leaderService.remove(+id);
  }

  @Get(':id/candidates')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Leader ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Get candidates of a leader',
    description: 'Returns all candidates associated with a specific leader'
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
          updatedAt: '2024-01-27T10:30:00Z'
        }
      ]
    }
  })
  @ApiResponse({ 
    status: 404, 
    description: 'Leader not found'
  })
  async getCandidates(@Param('id') id: string): Promise<Candidate[]> {
    return await this.leaderService.getCandidates(+id);
  }
}

import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { 
  ApiTags, 
  ApiOperation, 
  ApiResponse, 
  ApiParam,
  ApiBody
} from '@nestjs/swagger';
import { VoterService } from './voter.service';
import { CreateVoterDto } from './dto/create-voter.dto';
import { UpdateVoterDto } from './dto/update-voter.dto';
import { Voter } from '../../database/entities/voter.entity';

@ApiTags('Voters')
@Controller('voters')
export class VoterController {
  constructor(private readonly voterService: VoterService) {}

  @Post()
  @ApiOperation({ 
    summary: 'Create a new voter',
    description: 'Register a new voter in the system'
  })
  @ApiBody({
    type: CreateVoterDto,
    description: 'Voter data',
    examples: {
      example1: {
        value: {
          firstName: 'Juan',
          lastName: 'Pérez García',
          identification: '1234567890',
          gender: 'M',
          bloodType: 'O+',
          birthDate: '1980-01-15',
          phone: '+57 312 123 4567',
          address: 'Cra 5 #12-34 Apt 201',
          departmentId: 1,
          municipalityId: 1,
          neighborhood: 'Centro',
          email: 'voter@example.com',
          occupation: 'Ingeniero',
          votingLocation: 'Escuela Distrital Juan',
          votingBooth: 'Booth 1',
          politicalStatus: 'Active'
        },
        description: 'Example of creating a voter'
      }
    }
  })
  @ApiResponse({ 
    status: 201, 
    description: 'Voter created successfully',
    schema: {
      example: {
        id: 1,
        firstName: 'Juan',
        lastName: 'Pérez García',
        identification: '1234567890',
        gender: 'M',
        bloodType: 'O+',
        birthDate: '1980-01-15',
        phone: '+57 312 123 4567',
        address: 'Cra 5 #12-34 Apt 201',
        departmentId: 1,
        municipalityId: 1,
        neighborhood: 'Centro',
        email: 'voter@example.com',
        occupation: 'Ingeniero',
        votingLocation: 'Escuela Distrital Juan',
        votingBooth: 'Booth 1',
        politicalStatus: 'Active',
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z'
      }
    }
  })
  async create(@Body() createVoterDto: CreateVoterDto): Promise<Voter> {
    return await this.voterService.create(createVoterDto);
  }

  @Get()
  @ApiOperation({ 
    summary: 'Get all voters',
    description: 'Returns the complete list of registered voters'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'List of voters retrieved successfully'
  })
  async findAll(): Promise<Voter[]> {
    return await this.voterService.findAll();
  }

  @Get(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Voter ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Get voter by ID',
    description: 'Returns a specific voter'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'Voter found'
  })
  async findOne(@Param('id') id: string): Promise<Voter | null> {
    return await this.voterService.findOne(+id);
  }

  @Patch(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Voter ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Update a voter',
    description: 'Update voter information'
  })
  @ApiBody({
    type: UpdateVoterDto,
    description: 'Voter data to update',
    examples: {
      example1: {
        value: {
          phone: '+57 312 999 8888'
        },
        description: 'Example of updating voter phone'
      }
    }
  })
  @ApiResponse({ 
    status: 200, 
    description: 'Voter updated successfully'
  })
  async update(
    @Param('id') id: string,
    @Body() updateVoterDto: UpdateVoterDto,
  ): Promise<Voter | null> {
    return await this.voterService.update(+id, updateVoterDto);
  }

  @Delete(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Voter ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Delete a voter',
    description: 'Delete a voter from the system'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'Voter deleted successfully'
  })
  async remove(@Param('id') id: string): Promise<void> {
    return await this.voterService.remove(+id);
  }
}

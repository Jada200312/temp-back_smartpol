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
import { VoterService } from './voter.service';
import { CreateVoterDto } from './dto/create-voter.dto';
import { UpdateVoterDto } from './dto/update-voter.dto';
import { AssignCandidateDto } from './dto/assign-candidate.dto';
import { VoterReportFilterDto } from './dto/voter-report.dto';
import {
  PaginationQueryDto,
  PaginatedResponseDto,
} from './dto/pagination-query.dto';
import { Voter } from '../../database/entities/voter.entity';
import { CandidateVoter } from '../../database/entities/candidate-voter.entity';

@ApiTags('Voters')
@Controller('voters')
export class VoterController {
  constructor(private readonly voterService: VoterService) {}

  @Post()
  @ApiOperation({
    summary: 'Create a new voter',
    description: 'Register a new voter in the system',
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
          politicalStatus: 'Active',
        },
        description: 'Example of creating a voter',
      },
    },
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
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  async create(@Body() createVoterDto: CreateVoterDto): Promise<Voter> {
    return await this.voterService.create(createVoterDto);
  }

  @Get()
  @ApiOperation({
    summary: 'Get all voters with pagination',
    description: 'Returns a paginated list of registered voters',
  })
  @ApiQuery({
    name: 'page',
    type: Number,
    required: false,
    example: 1,
    description: 'Page number (starting from 1)',
  })
  @ApiQuery({
    name: 'limit',
    type: Number,
    required: false,
    example: 20,
    description: 'Number of items per page (max 100)',
  })
  @ApiResponse({
    status: 200,
    description: 'List of voters retrieved successfully',
  })
  async findAll(
    @Query() paginationQueryDto: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<Voter>> {
    return await this.voterService.findAllPaginated(paginationQueryDto);
  }

  @Get(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Voter ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get voter by ID',
    description: 'Returns a specific voter',
  })
  @ApiResponse({
    status: 200,
    description: 'Voter found',
  })
  async findOne(@Param('id') id: string): Promise<Voter | null> {
    return await this.voterService.findOne(+id);
  }

  @Patch(':id')
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'Voter ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Update a voter',
    description: 'Update voter information',
  })
  @ApiBody({
    type: UpdateVoterDto,
    description: 'Voter data to update',
    examples: {
      example1: {
        value: {
          phone: '+57 312 999 8888',
        },
        description: 'Example of updating voter phone',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'Voter updated successfully',
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
    example: 1,
  })
  @ApiOperation({
    summary: 'Delete a voter',
    description: 'Delete a voter from the system',
  })
  @ApiResponse({
    status: 200,
    description: 'Voter deleted successfully',
  })
  async remove(@Param('id') id: string): Promise<void> {
    return await this.voterService.remove(+id);
  }

  @Post(':voterId/assign-candidate')
  @ApiParam({
    name: 'voterId',
    type: 'number',
    description: 'Voter ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Assign candidates to voter',
    description:
      'Associate one or more candidates (and a leader) with a voter in the system',
  })
  @ApiBody({
    type: AssignCandidateDto,
    description: 'Candidates and leader to assign',
    examples: {
      example1: {
        value: {
          candidate_ids: [2, 3],
          leader_id: 1,
        },
        description:
          'Example of assigning candidate IDs 2 and 3 and leader ID 1 to voter',
      },
      example2: {
        value: {
          candidate_ids: [2],
          leader_id: 1,
        },
        description:
          'Example of assigning single candidate ID 2 with leader ID 1 to voter',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'Candidates assigned successfully',
    schema: {
      example: [
        {
          id: 1,
          voter_id: 1,
          candidate_id: 2,
          leader_id: 1,
          candidate: {
            id: 2,
            name: 'Carlos López',
          },
          leader: {
            id: 1,
            name: 'Juan Pérez',
          },
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z',
        },
        {
          id: 2,
          voter_id: 1,
          candidate_id: 3,
          leader_id: 1,
          candidate: {
            id: 3,
            name: 'María García',
          },
          leader: {
            id: 1,
            name: 'Juan Pérez',
          },
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z',
        },
      ],
    },
  })
  @ApiResponse({
    status: 400,
    description: 'Voter, candidate or leader not found',
  })
  async assignCandidates(
    @Param('voterId') voterId: string,
    @Body() assignCandidateDto: AssignCandidateDto,
  ): Promise<CandidateVoter[]> {
    return await this.voterService.updateAssignedCandidates(
      +voterId,
      assignCandidateDto,
    );
  }

  @Get(':voterId/assign-candidate')
  @ApiParam({
    name: 'voterId',
    type: 'number',
    description: 'Voter ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get assigned candidates for voter',
    description: 'Retrieve all candidates and leader assigned to a voter',
  })
  @ApiResponse({
    status: 200,
    description: 'Assignments retrieved successfully',
    schema: {
      example: [
        {
          id: 1,
          voter_id: 1,
          candidate_id: 2,
          leader_id: 1,
          candidate: {
            id: 2,
            name: 'Carlos López',
          },
          leader: {
            id: 1,
            name: 'Juan Pérez',
          },
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z',
        },
      ],
    },
  })
  @ApiResponse({
    status: 200,
    description: 'No assignments found for this voter',
  })
  async getAssignedCandidates(
    @Param('voterId') voterId: string,
  ): Promise<CandidateVoter[]> {
    return await this.voterService.getAssignedCandidates(+voterId);
  }

  @Patch(':voterId/assign-candidate')
  @ApiParam({
    name: 'voterId',
    type: 'number',
    description: 'Voter ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Update assigned candidates for voter',
    description:
      'Update the candidates and leader assigned to a voter. Replaces all previous assignments.',
  })
  @ApiBody({
    type: AssignCandidateDto,
    description: 'Candidates and leader to assign',
    examples: {
      example1: {
        value: {
          candidate_ids: [2, 3],
          leader_id: 2,
        },
        description: 'Example of updating with candidates 2 and 3 and leader 2',
      },
      example2: {
        value: {
          candidate_ids: [3],
          leader_id: 2,
        },
        description: 'Example of updating with single candidate 3 and leader 2',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'Assignments updated successfully',
    schema: {
      example: [
        {
          id: 1,
          voter_id: 1,
          candidate_id: 2,
          leader_id: 2,
          candidate: {
            id: 2,
            name: 'Carlos López',
          },
          leader: {
            id: 2,
            name: 'Pedro López',
          },
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T11:45:00Z',
        },
        {
          id: 5,
          voter_id: 1,
          candidate_id: 3,
          leader_id: 2,
          candidate: {
            id: 3,
            name: 'María García',
          },
          leader: {
            id: 2,
            name: 'Pedro López',
          },
          createdAt: '2024-01-27T10:35:00Z',
          updatedAt: '2024-01-27T11:45:00Z',
        },
      ],
    },
  })
  @ApiResponse({
    status: 400,
    description: 'Voter, candidate or leader not found',
  })
  async updateAssignedCandidates(
    @Param('voterId') voterId: string,
    @Body() assignCandidateDto: AssignCandidateDto,
  ): Promise<CandidateVoter[]> {
    return await this.voterService.updateAssignedCandidates(
      +voterId,
      assignCandidateDto,
    );
  }

  @Get('report/general')
  @ApiOperation({
    summary: 'Get voter report with filters and aggregations',
    description:
      'Get a detailed report of voters with dynamic filters and aggregations',
  })
  @ApiQuery({
    name: 'gender',
    type: 'string',
    required: false,
    description: 'Filter by gender (M, F, etc)',
  })
  @ApiQuery({
    name: 'leaderId',
    type: 'number',
    required: false,
    description: 'Filter by leader ID',
  })
  @ApiQuery({
    name: 'candidateId',
    type: 'number',
    required: false,
    description: 'Filter by candidate ID',
  })
  @ApiQuery({
    name: 'corporationId',
    type: 'number',
    required: false,
    description: 'Filter by corporation ID',
  })
  @ApiQuery({
    name: 'departmentId',
    type: 'number',
    required: false,
    description: 'Filter by department ID',
  })
  @ApiQuery({
    name: 'municipalityId',
    type: 'number',
    required: false,
    description: 'Filter by municipality ID',
  })
  @ApiQuery({
    name: 'votingLocation',
    type: 'string',
    required: false,
    description: 'Filter by voting location',
  })
  @ApiQuery({
    name: 'page',
    type: 'number',
    required: false,
    description: 'Page number (default: 1)',
  })
  @ApiQuery({
    name: 'limit',
    type: 'number',
    required: false,
    description: 'Records per page (default: 50)',
  })
  @ApiResponse({
    status: 200,
    description: 'Voter report retrieved successfully',
  })
  async getVoterReport(@Query() filters: VoterReportFilterDto): Promise<any> {
    return await this.voterService.getVoterReport(filters);
  }
}

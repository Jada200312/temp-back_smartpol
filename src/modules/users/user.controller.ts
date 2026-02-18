import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Query,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiBody,
  ApiBearerAuth,
  ApiQuery,
} from '@nestjs/swagger';
import { UserService } from './user.service';
import { Permission } from '../../permissions/permission.decorator';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { User } from '../../database/entities/user.entity';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Users')
@Controller('users')
@ApiBearerAuth('access-token')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  @Permission('users:create')
  @ApiOperation({
    summary: 'Create a new user',
    description: 'Register a new user in the system',
  })
  @ApiBody({
    type: CreateUserDto,
    description: 'User data',
    examples: {
      example1: {
        value: {
          email: 'user@example.com',
          password: 'password123',
        },
        description: 'Example of creating a user',
      },
    },
  })
  @ApiResponse({
    status: 201,
    description: 'User created successfully',
    schema: {
      example: {
        id: 1,
        email: 'user@example.com',
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  async create(@Body() createUserDto: CreateUserDto): Promise<User> {
    return await this.userService.create(createUserDto);
  }

  @Get()
  @Permission('users:read')
  @ApiOperation({
    summary: 'Get all users or users by role',
    description:
      'Returns the complete list of registered users, optionally filtered by role, with pagination and search support',
  })
  @ApiQuery({
    name: 'roleId',
    type: 'number',
    required: false,
    description: 'Optional role ID to filter users',
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
    description: 'Search by email (case-insensitive)',
  })
  @ApiResponse({
    status: 200,
    description: 'List of users retrieved successfully',
  })
  async findAll(
    @Query('roleId') roleId?: string,
    @Query('page') page: string = '1',
    @Query('limit') limit: string = '10',
    @Query('search') search?: string,
  ) {
    const pageNum = Math.max(1, parseInt(page, 10) || 1);
    const limitNum = Math.max(1, parseInt(limit, 10) || 10);

    if (roleId) {
      return await this.userService.findByRoleWithPagination(
        +roleId,
        pageNum,
        limitNum,
        search,
      );
    }
    // Si no hay roleId pero hay paginación, devolveremos los datos con la estructura de paginación
    return await this.userService.findAll();
  }

  @Get(':id')
  @Permission('users:read')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'User ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Get user by ID',
    description: 'Returns a specific user',
  })
  @ApiResponse({
    status: 200,
    description: 'User found',
    schema: {
      example: {
        id: 1,
        email: 'user@example.com',
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z',
      },
    },
  })
  async findOne(@Param('id') id: string): Promise<User | null> {
    return await this.userService.findOne(+id);
  }

  @Patch(':id')
  @Permission('users:update')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'User ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Update a user',
    description: 'Update user information',
  })
  @ApiBody({
    type: UpdateUserDto,
    description: 'User data to update',
    examples: {
      example1: {
        value: {
          email: 'newemail@example.com',
        },
        description: 'Example of updating user email',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'User updated successfully',
    schema: {
      example: {
        id: 1,
        email: 'newemail@example.com',
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:01Z',
      },
    },
  })
  async update(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUserDto,
  ): Promise<User | null> {
    return await this.userService.update(+id, updateUserDto);
  }

  @Delete(':id')
  @Permission('users:delete')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'User ID',
    example: 1,
  })
  @ApiOperation({
    summary: 'Delete a user',
    description: 'Delete a user from the system',
  })
  @ApiResponse({
    status: 200,
    description: 'User deleted successfully',
  })
  async remove(@Param('id') id: string): Promise<void> {
    return await this.userService.remove(+id);
  }

  @Post(':userId/campaigns/:campaignId')
  @Permission('users:update')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'userId',
    type: 'number',
    description: 'User ID',
  })
  @ApiParam({
    name: 'campaignId',
    type: 'number',
    description: 'Campaign ID',
  })
  @ApiOperation({ summary: 'Assign user to campaign' })
  @ApiResponse({
    status: 201,
    description: 'User assigned to campaign successfully',
  })
  assignUserToCampaign(
    @Param('userId') userId: string,
    @Param('campaignId') campaignId: string,
  ) {
    return this.userService.assignUserToCampaigns(+userId, [+campaignId]);
  }

  @Delete(':userId/campaigns/:campaignId')
  @Permission('users:update')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'userId',
    type: 'number',
    description: 'User ID',
  })
  @ApiParam({
    name: 'campaignId',
    type: 'number',
    description: 'Campaign ID',
  })
  @ApiOperation({ summary: 'Remove user from campaign' })
  @ApiResponse({
    status: 200,
    description: 'User removed from campaign successfully',
  })
  removeUserFromCampaign(
    @Param('userId') userId: string,
    @Param('campaignId') campaignId: string,
  ) {
    return this.userService.removeUserFromCampaign(+userId, +campaignId);
  }
}

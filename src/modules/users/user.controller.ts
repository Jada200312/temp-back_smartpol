import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { 
  ApiTags, 
  ApiOperation, 
  ApiResponse, 
  ApiParam,
  ApiBody,
  ApiBearerAuth
} from '@nestjs/swagger';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { User } from '../../database/entities/user.entity';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Users')
@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  @ApiOperation({ 
    summary: 'Create a new user',
    description: 'Register a new user in the system'
  })
  @ApiBody({
    type: CreateUserDto,
    description: 'User data',
    examples: {
      example1: {
        value: {
          email: 'user@example.com',
          password: 'password123'
        },
        description: 'Example of creating a user'
      }
    }
  })
  @ApiResponse({ 
    status: 201, 
    description: 'User created successfully',
    schema: {
      example: {
        id: 1,
        email: 'user@example.com',
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z'
      }
    }
  })
  async create(@Body() createUserDto: CreateUserDto): Promise<User> {
    return await this.userService.create(createUserDto);
  }

  @Get()
  @ApiOperation({ 
    summary: 'Get all users',
    description: 'Returns the complete list of registered users'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'List of users retrieved successfully',
    schema: {
      example: [
        {
          id: 1,
          email: 'user@example.com',
          createdAt: '2024-01-27T10:30:00Z',
          updatedAt: '2024-01-27T10:30:00Z'
        }
      ]
    }
  })
  async findAll(): Promise<User[]> {
    return await this.userService.findAll();
  }

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'User ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Get user by ID',
    description: 'Returns a specific user'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'User found',
    schema: {
      example: {
        id: 1,
        email: 'user@example.com',
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:00Z'
      }
    }
  })
  async findOne(@Param('id') id: string): Promise<User | null> {
    return await this.userService.findOne(+id);
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'User ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Update a user',
    description: 'Update user information'
  })
  @ApiBody({
    type: UpdateUserDto,
    description: 'User data to update',
    examples: {
      example1: {
        value: {
          email: 'newemail@example.com'
        },
        description: 'Example of updating user email'
      }
    }
  })
  @ApiResponse({ 
    status: 200, 
    description: 'User updated successfully',
    schema: {
      example: {
        id: 1,
        email: 'newemail@example.com',
        createdAt: '2024-01-27T10:30:00Z',
        updatedAt: '2024-01-27T10:30:01Z'
      }
    }
  })
  async update(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUserDto,
  ): Promise<User | null> {
    return await this.userService.update(+id, updateUserDto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'User ID',
    example: 1
  })
  @ApiOperation({ 
    summary: 'Delete a user',
    description: 'Delete a user from the system'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'User deleted successfully'
  })
  async remove(@Param('id') id: string): Promise<void> {
    return await this.userService.remove(+id);
  }
}

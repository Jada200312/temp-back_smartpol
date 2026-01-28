import { IsEmail, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateUserDto {
  @ApiProperty({ 
    example: 'newemail@example.com',
    description: 'User email address (optional)',
    required: false
  })
  @IsEmail()
  @IsOptional()
  email?: string;
}

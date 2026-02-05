import { IsString, IsOptional, IsNumber } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateLeaderDto {
  @ApiProperty({
    example: 'Juan López',
    description: 'Leader name (optional)',
  })
  @IsString()
  @IsOptional()
  name?: string;

  @ApiProperty({
    example: '12345678',
    description: 'Leader identification document (optional)',
  })
  @IsString()
  @IsOptional()
  document?: string;

  @ApiProperty({
    example: 'Bogotá',
    description: 'Municipality where the leader is from (optional)',
  })
  @IsString()
  @IsOptional()
  municipality?: string;

  @ApiProperty({
    example: '+57 312 123 4567',
    description: 'Leader phone number (optional)',
  })
  @IsString()
  @IsOptional()
  phone?: string;

  @ApiProperty({
    example: 1,
    description: 'User ID associated with the leader (optional)',
  })
  @IsNumber()
  @IsOptional()
  userId?: number;
}

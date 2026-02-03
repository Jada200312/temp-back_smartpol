import {
  IsString,
  IsOptional,
  IsEmail,
  IsDateString,
  IsNumber,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateVoterDto {
  @ApiProperty({
    example: 'Juan',
    description: 'Voter first name (optional)',
  })
  @IsString()
  @IsOptional()
  firstName?: string;

  @ApiProperty({
    example: 'Pérez García',
    description: 'Voter last name (optional)',
  })
  @IsString()
  @IsOptional()
  lastName?: string;

  @ApiProperty({
    example: '1234567890',
    description: 'Voter identification number (optional)',
  })
  @IsString()
  @IsOptional()
  identification?: string;

  @ApiProperty({
    example: 'M',
    description: 'Voter gender, M for male or F for female (optional)',
  })
  @IsString()
  @IsOptional()
  gender?: string;

  @ApiProperty({
    example: 'O+',
    description: 'Voter blood type (optional)',
  })
  @IsString()
  @IsOptional()
  bloodType?: string;

  @ApiProperty({
    example: '1980-01-15',
    description: 'Voter birth date in YYYY-MM-DD format (optional)',
  })
  @IsDateString()
  @IsOptional()
  birthDate?: string;

  @ApiProperty({
    example: '+57 312 123 4567',
    description: 'Voter phone number (optional)',
  })
  @IsString()
  @IsOptional()
  phone?: string;

  @ApiProperty({
    example: 'Cra 5 #12-34 Apt 201',
    description: 'Voter physical address (optional)',
  })
  @IsString()
  @IsOptional()
  address?: string;

  @ApiProperty({
    example: 1,
    description: 'Department ID (optional)',
  })
  @IsNumber()
  @IsOptional()
  departmentId?: number;

  @ApiProperty({
    example: 1,
    description: 'Municipality ID (optional)',
  })
  @IsNumber()
  @IsOptional()
  municipalityId?: number;

  @ApiProperty({
    example: 'Centro',
    description: 'Voter neighborhood (optional)',
  })
  @IsString()
  @IsOptional()
  neighborhood?: string;

  @ApiProperty({
    example: 'voter@example.com',
    description: 'Voter email address (optional)',
  })
  @IsEmail()
  @IsOptional()
  email?: string;

  @ApiProperty({
    example: 'Ingeniero',
    description: 'Voter occupation or job title (optional)',
  })
  @IsString()
  @IsOptional()
  occupation?: string;

  @ApiProperty({
    example: 1,
    description: 'Voting Booth ID (optional)',
  })
  @IsNumber()
  @IsOptional()
  votingBoothId?: number;

  @ApiProperty({
    example: 1,
    description: 'Voting Table ID or Mesa number (optional)',
  })
  @IsString()
  @IsOptional()
  votingTableId?: string;

  @ApiProperty({
    example: 'Active',
    description: 'Voter political status (Active, Inactive, etc.) (optional)',
  })
  @IsString()
  @IsOptional()
  politicalStatus?: string;
}

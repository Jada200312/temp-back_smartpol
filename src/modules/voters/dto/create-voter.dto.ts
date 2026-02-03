import {
  IsString,
  IsNotEmpty,
  IsEmail,
  IsDateString,
  IsNumber,
  IsOptional,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateVoterDto {
  @ApiProperty({
    example: 'Juan',
    description: 'Voter first name (required)',
  })
  @IsString()
  @IsNotEmpty()
  firstName: string;

  @ApiProperty({
    example: 'Pérez García',
    description: 'Voter last name (required)',
  })
  @IsString()
  @IsNotEmpty()
  lastName: string;

  @ApiProperty({
    example: '1234567890',
    description: 'Voter identification number (required)',
  })
  @IsString()
  @IsNotEmpty()
  identification: string;

  @ApiProperty({
    example: 'M',
    description: 'Voter gender, M for male or F for female (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  gender?: string;

  @ApiProperty({
    example: 'O+',
    description: 'Voter blood type (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  bloodType?: string;

  @ApiProperty({
    example: '1980-01-15',
    description: 'Voter birth date in YYYY-MM-DD format (optional)',
    required: false,
  })
  @IsDateString()
  @IsOptional()
  birthDate?: string;

  @ApiProperty({
    example: '+57 312 123 4567',
    description: 'Voter phone number (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  phone?: string;

  @ApiProperty({
    example: 'Cra 5 #12-34 Apt 201',
    description: 'Voter physical address (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  address?: string;

  @ApiProperty({
    example: 1,
    description: 'Department ID (required)',
  })
  @IsNumber()
  @IsNotEmpty()
  departmentId: number;

  @ApiProperty({
    example: 1,
    description: 'Municipality ID (required)',
  })
  @IsNumber()
  @IsNotEmpty()
  municipalityId: number;

  @ApiProperty({
    example: 'Centro',
    description: 'Voter neighborhood (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  neighborhood?: string;

  @ApiProperty({
    example: 'voter@example.com',
    description: 'Voter email address (optional)',
    required: false,
  })
  @IsEmail()
  @IsOptional()
  email?: string;

  @ApiProperty({
    example: 'Ingeniero',
    description: 'Voter occupation or job title (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  occupation?: string;

  @ApiProperty({
    example: 1,
    description: 'Voting Booth ID (optional)',
    required: false,
  })
  @IsNumber()
  @IsOptional()
  votingBoothId?: number;

  @ApiProperty({
    example: 1,
    description: 'Voting Table ID or Mesa number (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  votingTableId?: string;

  @ApiProperty({
    example: 'Active',
    description: 'Voter political status (optional)',
    required: false,
  })
  @IsString()
  @IsOptional()
  politicalStatus?: string;
}

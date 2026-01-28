import { IsString, IsNotEmpty, IsEmail, IsDateString, IsNumber } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateVoterDto {
  @ApiProperty({ 
    example: 'Juan',
    description: 'Voter first name (required)'
  })
  @IsString()
  @IsNotEmpty()
  firstName: string;

  @ApiProperty({ 
    example: 'Pérez García',
    description: 'Voter last name (required)'
  })
  @IsString()
  @IsNotEmpty()
  lastName: string;

  @ApiProperty({ 
    example: '1234567890',
    description: 'Voter identification number (required)'
  })
  @IsString()
  @IsNotEmpty()
  identification: string;

  @ApiProperty({ 
    example: 'M',
    description: 'Voter gender, M for male or F for female (required)'
  })
  @IsString()
  @IsNotEmpty()
  gender: string;

  @ApiProperty({ 
    example: 'O+',
    description: 'Voter blood type (required)'
  })
  @IsString()
  @IsNotEmpty()
  bloodType: string;

  @ApiProperty({ 
    example: '1980-01-15',
    description: 'Voter birth date in YYYY-MM-DD format (required)'
  })
  @IsDateString()
  @IsNotEmpty()
  birthDate: string;

  @ApiProperty({ 
    example: '+57 312 123 4567',
    description: 'Voter phone number (required)'
  })
  @IsString()
  @IsNotEmpty()
  phone: string;

  @ApiProperty({ 
    example: 'Cra 5 #12-34 Apt 201',
    description: 'Voter physical address (required)'
  })
  @IsString()
  @IsNotEmpty()
  address: string;

  @ApiProperty({ 
    example: 1,
    description: 'Department ID (required)'
  })
  @IsNumber()
  @IsNotEmpty()
  departmentId: number;

  @ApiProperty({ 
    example: 1,
    description: 'Municipality ID (required)'
  })
  @IsNumber()
  @IsNotEmpty()
  municipalityId: number;

  @ApiProperty({ 
    example: 'Centro',
    description: 'Voter neighborhood (required)'
  })
  @IsString()
  @IsNotEmpty()
  neighborhood: string;

  @ApiProperty({ 
    example: 'voter@example.com',
    description: 'Voter email address (required)'
  })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiProperty({ 
    example: 'Ingeniero',
    description: 'Voter occupation or job title (required)'
  })
  @IsString()
  @IsNotEmpty()
  occupation: string;

  @ApiProperty({ 
    example: 'Escuela Distrital Juan',
    description: 'Voter voting location or polling station (required)'
  })
  @IsString()
  @IsNotEmpty()
  votingLocation: string;

  @ApiProperty({ 
    example: 'Booth 1',
    description: 'Voter voting booth number or identifier (required)'
  })
  @IsString()
  @IsNotEmpty()
  votingBooth: string;

  @ApiProperty({ 
    example: 'Active',
    description: 'Voter political status (Active, Inactive, etc.) (required)'
  })
  @IsString()
  @IsNotEmpty()
  politicalStatus: string;
}

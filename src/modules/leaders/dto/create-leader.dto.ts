import { IsString, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateLeaderDto {
  @ApiProperty({ 
    example: 'Juan López',
    description: 'Leader name (required)'
  })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({ 
    example: '12345678',
    description: 'Leader identification document (required)'
  })
  @IsString()
  @IsNotEmpty()
  document: string;

  @ApiProperty({ 
    example: 'Bogotá',
    description: 'Municipality where the leader is from (required)'
  })
  @IsString()
  @IsNotEmpty()
  municipality: string;

  @ApiProperty({ 
    example: '+57 312 123 4567',
    description: 'Leader phone number (required)'
  })
  @IsString()
  @IsNotEmpty()
  phone: string;
}

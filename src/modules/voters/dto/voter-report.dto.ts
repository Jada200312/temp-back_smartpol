import { IsOptional, IsString, IsNumber, Min, Max } from 'class-validator';
import { Type } from 'class-transformer';

export class VoterReportFilterDto {
  @IsOptional()
  @IsString()
  gender?: string;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  leaderId?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  candidateId?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  corporationId?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  departmentId?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  municipalityId?: number;

  @IsOptional()
  @IsString()
  votingLocation?: string;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(1)
  page?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(1)
  @Max(500)
  limit?: number;
}

export class VoterReportDto {
  id: number;
  firstName: string;
  lastName: string;
  identification: string;
  gender: string;
  phone: string;
  email: string;
  departmentId: number;
  department?: {
    id: number;
    name: string;
  };
  municipalityId: number;
  municipality?: {
    id: number;
    name: string;
  };
  neighborhood: string;
  votingLocation: string;
  votingBooth: string;
  candidates?: Array<{
    id: number;
    name: string;
    party: string;
    number: number;
    corporation?: {
      id: number;
      name: string;
    };
  }>;
  leaders?: Array<{
    id: number;
    name: string;
  }>;
}

import { IsNumber, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class AssignCandidateDto {
  @ApiProperty({
    example: 2,
    description: 'Candidate ID to assign to the voter (required)',
  })
  @IsNumber()
  @IsNotEmpty()
  candidate_id: number;

  @ApiProperty({
    example: 1,
    description: 'Leader ID to assign to the voter (required)',
  })
  @IsNumber()
  @IsNotEmpty()
  leader_id: number;
}

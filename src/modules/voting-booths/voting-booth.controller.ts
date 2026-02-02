import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  ParseIntPipe,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { VotingBoothService } from './voting-booth.service';
import { CreateVotingBoothDto } from './dto/create-voting-booth.dto';
import { UpdateVotingBoothDto } from './dto/update-voting-booth.dto';
import { VotingBoothResponseDto } from './dto/voting-booth-response.dto';

@ApiTags('Voting Booths')
@Controller('voting-booths')
export class VotingBoothController {
  constructor(private readonly votingBoothService: VotingBoothService) {}

  @Post()
  @ApiOperation({ summary: 'Crear nuevo puesto de votación' })
  @ApiResponse({
    status: 201,
    description: 'Puesto creado exitosamente',
    type: VotingBoothResponseDto,
  })
  create(@Body() createVotingBoothDto: CreateVotingBoothDto) {
    return this.votingBoothService.create(createVotingBoothDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener todos los puestos de votación' })
  @ApiResponse({
    status: 200,
    description: 'Lista de puestos',
    type: [VotingBoothResponseDto],
  })
  findAll() {
    return this.votingBoothService.findAll();
  }

  @Get('by-municipality/:municipalityId')
  @ApiOperation({ summary: 'Obtener puestos por municipio' })
  @ApiResponse({
    status: 200,
    description: 'Puestos del municipio',
    type: [VotingBoothResponseDto],
  })
  findByMunicipality(
    @Param('municipalityId', ParseIntPipe) municipalityId: number,
  ) {
    return this.votingBoothService.findByMunicipality(municipalityId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener puesto por ID' })
  @ApiResponse({
    status: 200,
    description: 'Puesto encontrado',
    type: VotingBoothResponseDto,
  })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.votingBoothService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Actualizar puesto de votación' })
  @ApiResponse({
    status: 200,
    description: 'Puesto actualizado',
    type: VotingBoothResponseDto,
  })
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateVotingBoothDto: UpdateVotingBoothDto,
  ) {
    return this.votingBoothService.update(id, updateVotingBoothDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Eliminar puesto de votación' })
  @ApiResponse({ status: 200, description: 'Puesto eliminado' })
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.votingBoothService.remove(id);
  }
}
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './modules/auth/auth.module';
import { CorporationModule } from './modules/corporations/corporation.module';
import { UserModule } from './modules/users/user.module';
import { LeaderModule } from './modules/leaders/leader.module';
import { VoterModule } from './modules/voters/voter.module';
import { CandidateModule } from './modules/candidates/candidate.module';
import { DepartmentModule } from './modules/departments/department.module';
import { MunicipalityModule } from './modules/municipalities/municipality.module';
import {
  User,
  Candidate,
  Leader,
  Corporation,
  Voter,
  Department,
  Municipality,
  CandidateVoter,
} from './database/entities';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT || '5236', 10),
      username: process.env.DB_USERNAME || 'temp-smartpol_user',
      password: process.env.DB_PASSWORD || 'temp-smartpol_password',
      database: process.env.DB_DATABASE || 'temp-smartpol_db',
      entities: [
        User,
        Candidate,
        Leader,
        Corporation,
        Voter,
        Department,
        Municipality,
        CandidateVoter,
      ],
      synchronize: false,
      logging: process.env.NODE_ENV === 'development',
    }),
    AuthModule,
    CorporationModule,
    UserModule,
    LeaderModule,
    VoterModule,
    CandidateModule,
    DepartmentModule,
    MunicipalityModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
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
import { VotingBoothModule } from './modules/voting-booths/voting-booth.module';
import { VotingTableModule } from './modules/voting-tables/voting-table.module';
import { PermissionsModule } from './permissions/permissions.module';
import { JwtAuthGuard } from './common/guards/jwt-auth.guard';
import {
  User,
  Role,
  Candidate,
  Leader,
  Corporation,
  Voter,
  Department,
  Municipality,
  CandidateVoter,
  VotingBooth,
  VotingTable,
  Permission,
  RolePermission,
  UserPermission,
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
        Role,
        Candidate,
        Leader,
        Corporation,
        Voter,
        Department,
        Municipality,
        CandidateVoter,
        VotingBooth,
        VotingTable,
        Permission,
        RolePermission,
        UserPermission,
      ],
      synchronize: false,
      logging:
        process.env.DB_LOGGING === 'true' ? ['query', 'error'] : ['error'],
      // Connection pool configuration for production
      extra: {
        max: parseInt(process.env.DB_POOL_SIZE || '20', 10),
        min: parseInt(process.env.DB_POOL_MIN || '5', 10),
        idleTimeoutMillis: parseInt(process.env.DB_IDLE_TIMEOUT || '30000', 10),
        connectionTimeoutMillis: parseInt(
          process.env.DB_CONNECTION_TIMEOUT || '5000',
          10,
        ),
        statement_timeout: parseInt(
          process.env.DB_STATEMENT_TIMEOUT || '30000',
          10,
        ),
      },
    }),
    TypeOrmModule.forFeature([
      User,
      Role,
      Candidate,
      Leader,
      Corporation,
      Voter,
      Department,
      Municipality,
      CandidateVoter,
      VotingBooth,
      VotingTable,
      Permission,
      RolePermission,
      UserPermission,
    ]),
    AuthModule,
    CorporationModule,
    UserModule,
    LeaderModule,
    VoterModule,
    CandidateModule,
    DepartmentModule,
    MunicipalityModule,
    VotingBoothModule,
    VotingTableModule,
    PermissionsModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
  ],
})
export class AppModule {}

import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { ConfigService } from '@nestjs/config';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtStrategy } from './strategies/jwt.strategy';
import { UserModule } from '../users/user.module';
import { PermissionsModule } from '../../permissions/permissions.module';

@Module({
  imports: [
    PassportModule,
    JwtModule.registerAsync({
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => {
        const jwtSecret =
          configService.get<string>('JWT_SECRET') ||
          'your-super-secret-jwt-key-change-this-in-production';
        const jwtExpiration =
          configService.get<string>('JWT_EXPIRATION') || '7d';
        return {
          secret: jwtSecret,
          signOptions: { expiresIn: jwtExpiration as any },
        };
      },
    }),
    UserModule,
    PermissionsModule,
  ],
  controllers: [AuthController],
  providers: [AuthService, JwtStrategy],
  exports: [AuthService, JwtModule],
})
export class AuthModule {}

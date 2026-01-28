import { Injectable, BadRequestException, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserService } from '../users/user.service';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private jwtService: JwtService,
    private userService: UserService,
  ) {}

  async register(registerDto: RegisterDto) {
    // Verificar si el usuario ya existe
    const existingUser = await this.userService.findByEmail(registerDto.email);
    if (existingUser) {
      throw new BadRequestException('User already exists');
    }

    // Hash de la contraseña
    const hashedPassword = await bcrypt.hash(registerDto.password, 10);

    // Crear nuevo usuario
    const usuario = await this.userService.create({
      email: registerDto.email,
      password: hashedPassword,
    });

    // Generar JWT
    const accessToken = await this.generateToken(usuario);
    const refreshToken = await this.generateRefreshToken(usuario);

    return {
      id: usuario.id,
      email: usuario.email,
      access_token: accessToken,
      refresh_token: refreshToken,
      message: 'User registered successfully',
    };
  }

  async login(loginDto: LoginDto) {
    // Buscar usuario
    const usuario = await this.userService.findByEmail(loginDto.email);
    if (!usuario) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Verificar contraseña
    const isPasswordValid = await bcrypt.compare(
      loginDto.password,
      usuario.password,
    );
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Generar JWT
    const accessToken = await this.generateToken(usuario);
    const refreshToken = await this.generateRefreshToken(usuario);

    return {
      id: usuario.id,
      email: usuario.email,
      access_token: accessToken,
      refresh_token: refreshToken,
      message: 'Login successful',
    };
  }

  async changePassword(userId: number, changePasswordDto: ChangePasswordDto) {
    // Validar que las contraseñas nuevas coincidan
    if (changePasswordDto.newPassword !== changePasswordDto.confirmPassword) {
      throw new BadRequestException('Passwords do not match');
    }

    // Obtener usuario
    const usuario = await this.userService.findOne(userId);
    if (!usuario) {
      throw new UnauthorizedException('User not found');
    }

    // Verificar contraseña actual
    const isPasswordValid = await bcrypt.compare(
      changePasswordDto.currentPassword,
      usuario.password,
    );
    if (!isPasswordValid) {
      throw new UnauthorizedException('Current password is incorrect');
    }

    // Hash de la nueva contraseña
    const hashedPassword = await bcrypt.hash(changePasswordDto.newPassword, 10);

    // Actualizar contraseña
    await this.userService.updatePassword(userId, hashedPassword);

    return {
      message: 'Password updated successfully',
    };
  }

  async refreshToken(refreshTokenString: string) {
    try {
      // Verify the refresh token
      const payload = this.jwtService.verify(refreshTokenString);
      
      // Get the user
      const user = await this.userService.findOne(payload.sub);
      if (!user) {
        throw new UnauthorizedException('User not found');
      }

      // Generate new access token
      const newAccessToken = await this.generateToken(user);
      
      // Generate new refresh token
      const newRefreshToken = await this.generateRefreshToken(user);

      return {
        id: user.id,
        email: user.email,
        access_token: newAccessToken,
        refresh_token: newRefreshToken,
        message: 'Token refreshed successfully',
      };
    } catch (error) {
      throw new UnauthorizedException('Invalid or expired refresh token');
    }
  }

  private async generateToken(usuario: any): Promise<string> {
    const payload = { email: usuario.email, sub: usuario.id };
    return this.jwtService.sign(payload);
  }

  private async generateRefreshToken(usuario: any): Promise<string> {
    const payload = { email: usuario.email, sub: usuario.id };
    return this.jwtService.sign(payload, { expiresIn: '30d' });
  }
}



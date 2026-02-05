import {
  CanActivate,
  ExecutionContext,
  Injectable,
  ForbiddenException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { PermissionsService } from './permissions.service';
import { PERMISSION_KEY } from './permission.decorator';

@Injectable()
export class PermissionGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private permissionsService: PermissionsService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // Obtener el permiso requerido del decorador
    const requiredPermission = this.reflector.get<string>(
      PERMISSION_KEY,
      context.getHandler(),
    );

    // Si no hay permiso requerido, permitir acceso
    if (!requiredPermission) {
      return true;
    }

    // Obtener el usuario del request
    const request = context.switchToHttp().getRequest();
    const user = request.user;

    // Si no hay usuario autenticado, denegar
    if (!user || !user.id) {
      throw new ForbiddenException('No autenticado');
    }

    const roleId = user.roleId || user.role?.id;

    // Verificar el permiso
    const hasPermission = await this.permissionsService.hasPermission(
      user.id,
      requiredPermission,
      roleId,
    );

    if (!hasPermission) {
      throw new ForbiddenException(
        `No tiene permiso para: ${requiredPermission}`,
      );
    }

    return true;
  }
}

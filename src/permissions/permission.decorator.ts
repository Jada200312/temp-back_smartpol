import { SetMetadata } from '@nestjs/common';

export const PERMISSION_KEY = 'permission';

/**
 * Decorador para especificar el permiso requerido en una ruta
 * @param permission Nombre del permiso (ej: 'candidates:read', 'voters:create')
 */
export const Permission = (permission: string) =>
  SetMetadata(PERMISSION_KEY, permission);

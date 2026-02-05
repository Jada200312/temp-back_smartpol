import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
  Permission,
  RolePermission,
  UserPermission,
  User,
  Role,
} from '../database/entities';

@Injectable()
export class PermissionsService {
  private permissionCache: Map<string, boolean> = new Map();

  constructor(
    @InjectRepository(Permission)
    private permissionsRepo: Repository<Permission>,
    @InjectRepository(RolePermission)
    private rolePermissionsRepo: Repository<RolePermission>,
    @InjectRepository(UserPermission)
    private userPermissionsRepo: Repository<UserPermission>,
    @InjectRepository(User)
    private usersRepo: Repository<User>,
    @InjectRepository(Role)
    private rolesRepo: Repository<Role>,
  ) {}

  /**
   * Verifica si un usuario tiene un permiso específico
   * Lógica: permisos personalizados > permisos del rol
   */
  async hasPermission(
    userId: number,
    permissionName: string,
    roleId?: number,
  ): Promise<boolean> {
    if (!roleId) {
      // Si no hay rol, denegar acceso
      return false;
    }

    const cacheKey = `${userId}:${permissionName}`;

    // Verificar caché
    if (this.permissionCache.has(cacheKey)) {
      const cached = this.permissionCache.get(cacheKey);
      return cached ?? false;
    }

    // 1. Buscar permiso específico del usuario
    const userPermission = await this.userPermissionsRepo.findOne({
      where: { user: { id: userId }, permission: { name: permissionName } },
      relations: ['permission'],
    });

    if (userPermission) {
      this.permissionCache.set(cacheKey, userPermission.granted);
      return userPermission.granted;
    }

    // 2. Si no existe permiso específico, usar permiso del rol
    const rolePermission = await this.rolePermissionsRepo.findOne({
      where: { role: { id: roleId }, permission: { name: permissionName } },
      relations: ['permission'],
    });

    const hasAccess = !!rolePermission;
    this.permissionCache.set(cacheKey, hasAccess);
    return hasAccess;
  }

  /**
   * Obtiene todos los permisos de un usuario (rol + personalizados)
   */
  async getUserPermissions(userId: number, roleId: number): Promise<string[]> {
    // Permisos del rol
    const rolePerms = await this.rolePermissionsRepo.find({
      where: { role: { id: roleId } },
      relations: ['permission'],
    });

    const permissionNames = new Set(rolePerms.map((rp) => rp.permission.name));

    // Permisos personalizados del usuario
    const userPerms = await this.userPermissionsRepo.find({
      where: { user: { id: userId } },
      relations: ['permission'],
    });

    // Agregar/remover permisos personalizados
    userPerms.forEach((up) => {
      if (up.granted) {
        permissionNames.add(up.permission.name);
      } else {
        permissionNames.delete(up.permission.name);
      }
    });

    return Array.from(permissionNames);
  }

  /**
   * Otorga un permiso personalizado a un usuario
   */
  async grantPermission(userId: number, permissionName: string): Promise<void> {
    const permission = await this.permissionsRepo.findOne({
      where: { name: permissionName },
    });

    if (!permission) {
      throw new Error(`Permiso "${permissionName}" no existe`);
    }

    await this.userPermissionsRepo.upsert(
      {
        userId,
        permissionId: permission.id,
        granted: true,
      },
      ['userId', 'permissionId'],
    );

    this.invalidateCache(userId, permissionName);
  }

  /**
   * Revoca un permiso personalizado de un usuario
   */
  async revokePermission(
    userId: number,
    permissionName: string,
  ): Promise<void> {
    const permission = await this.permissionsRepo.findOne({
      where: { name: permissionName },
    });

    if (!permission) {
      throw new Error(`Permiso "${permissionName}" no existe`);
    }

    await this.userPermissionsRepo.upsert(
      {
        userId,
        permissionId: permission.id,
        granted: false,
      },
      ['userId', 'permissionId'],
    );

    this.invalidateCache(userId, permissionName);
  }

  /**
   * Establece el estado de un permiso personalizado para un usuario
   * granted: true = otorgar permiso adicional (no heredado del rol)
   * granted: false = revocar permiso heredado del rol
   * Si se llama nuevamente con el mismo estado, se borra el registro
   */
  async setUserPermission(
    userId: number,
    permissionName: string,
    granted: boolean,
  ): Promise<void> {
    const permission = await this.permissionsRepo.findOne({
      where: { name: permissionName },
    });

    if (!permission) {
      throw new Error(`Permiso "${permissionName}" no existe`);
    }

    // Verificar si ya existe un registro de permiso personalizado
    const existingPermission = await this.userPermissionsRepo.findOne({
      where: {
        user: { id: userId },
        permission: { id: permission.id },
      },
    });

    // Si ya existe y tiene el mismo estado, eliminar (volver al estado natural)
    if (existingPermission && existingPermission.granted === granted) {
      await this.userPermissionsRepo.delete({
        userId,
        permissionId: permission.id,
      });
    } else {
      // Si no existe o tiene diferente estado, upsert con el nuevo estado
      await this.userPermissionsRepo.upsert(
        {
          userId,
          permissionId: permission.id,
          granted,
        },
        ['userId', 'permissionId'],
      );
    }

    this.invalidateCache(userId, permissionName);
  }

  /**
   * Elimina un permiso personalizado de un usuario (limpia la excepción)
   * No UPSERT, DELETE real
   */
  async deleteUserPermission(
    userId: number,
    permissionName: string,
  ): Promise<void> {
    const permission = await this.permissionsRepo.findOne({
      where: { name: permissionName },
    });

    if (!permission) {
      throw new Error(`Permiso "${permissionName}" no existe`);
    }

    await this.userPermissionsRepo.delete({
      userId,
      permissionId: permission.id,
    });

    this.invalidateCache(userId, permissionName);
  }

  /**
   * Obtiene todos los permisos disponibles
   */
  async getAllPermissions(): Promise<Permission[]> {
    return this.permissionsRepo.find({
      order: { resource: 'ASC', action: 'ASC' },
    });
  }

  /**
   * Obtiene un permiso por ID
   */
  async getPermissionById(id: number): Promise<Permission | null> {
    return this.permissionsRepo.findOne({ where: { id } });
  }

  /**
   * Obtiene permisos agrupados por recurso
   */
  async getPermissionsByResource(): Promise<Record<string, Permission[]>> {
    const permissions = await this.getAllPermissions();
    return permissions.reduce(
      (acc, perm) => {
        if (!acc[perm.resource]) {
          acc[perm.resource] = [];
        }
        acc[perm.resource].push(perm);
        return acc;
      },
      {} as Record<string, Permission[]>,
    );
  }

  /**
   * Invalida el caché de un permiso
   */
  private invalidateCache(userId: number, permissionName: string): void {
    const cacheKey = `${userId}:${permissionName}`;
    this.permissionCache.delete(cacheKey);
  }

  /**
   * Limpia todo el caché (útil después de cambios de permisos masivos)
   */
  clearCache(): void {
    this.permissionCache.clear();
  }

  /**
   * Obtiene todos los usuarios con su rol
   */
  async getAllUsers(): Promise<User[]> {
    return this.usersRepo.find({
      relations: ['role'],
      order: { email: 'ASC' },
    });
  }

  /**
   * Obtiene todos los roles
   */
  async getAllRoles(): Promise<Role[]> {
    return this.rolesRepo.find({
      order: { id: 'ASC' },
    });
  }

  /**
   * Obtiene los permisos de un rol específico
   */
  async getRolePermissions(roleId: number): Promise<Permission[]> {
    const rolePerms = await this.rolePermissionsRepo.find({
      where: { role: { id: roleId } },
      relations: ['permission'],
    });
    return rolePerms.map((rp) => rp.permission);
  }

  /**
   * Obtiene los permisos personalizados de un usuario
   */
  async getUserCustomPermissions(userId: number): Promise<UserPermission[]> {
    return this.userPermissionsRepo.find({
      where: { user: { id: userId } },
      relations: ['permission'],
    });
  }

  /**
   * Asigna un permiso a un rol
   */
  async assignPermissionToRole(
    roleId: number,
    permissionId: number,
  ): Promise<void> {
    await this.rolePermissionsRepo.upsert(
      {
        roleId,
        permissionId,
      },
      ['roleId', 'permissionId'],
    );
    this.clearCache();
  }

  /**
   * Revoca un permiso de un rol
   */
  async revokePermissionFromRole(
    roleId: number,
    permissionId: number,
  ): Promise<void> {
    await this.rolePermissionsRepo.delete({
      roleId,
      permissionId,
    });
    this.clearCache();
  }
}

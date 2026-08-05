import 'package:warehouse_web_app/features/permission_management/models/permission_model.dart';

class PermissionDummyData {
  PermissionDummyData._();

  static const List<String> roles = [
    'Admin Office Team',
    'IMS Administrator',
    'Continues Improvement Team',
    'Finance Team',
    'HR Team',
    'Procurement Team',
    'QRC Team',
    'R&D Team',
    'Safety Team',
    'Super Admin',
  ];

  static List<bool> _access(Set<int> checkedIndexes) {
    return List.generate(roles.length, (i) => checkedIndexes.contains(i));
  }

  // Operational modules: everyone except Continues Improvement Team & Safety Team.
  static const _operational = {0, 1, 3, 4, 5, 6, 7, 9};
  // Admin-only modules: IMS Administrator + Super Admin only.
  static const _adminOnly = {1, 9};
  // User/Role/Permission: Admin Office, IMS Administrator, Super Admin.
  static const _userRolePermission = {0, 1, 9};

  static List<PermissionModel> imsPermissions() => [
        PermissionModel(moduleName: 'Dashboard', access: _access(_operational)),
        PermissionModel(moduleName: 'User, Role, Permission', access: _access(_userRolePermission)),
        PermissionModel(moduleName: 'Transactions', access: _access(_operational)),
        PermissionModel(moduleName: 'Report', access: _access(_adminOnly)),
        PermissionModel(moduleName: 'Label Print', access: _access(_adminOnly)),
      ];

  static List<PermissionModel> handheldPermissions() => [
        PermissionModel(moduleName: 'Good Receive', access: _access(_operational)),
        PermissionModel(moduleName: 'Transfer & Put Away', access: _access(_operational)),
        PermissionModel(moduleName: 'Pick & Pack', access: _access(_operational)),
        PermissionModel(moduleName: 'Outgoing', access: _access(_adminOnly)),
        PermissionModel(moduleName: 'Label Print', access: _access(_adminOnly)),
      ];
}
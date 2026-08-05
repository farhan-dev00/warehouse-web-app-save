/// Domain model for a single role row.
class Role {
  final String roleCode;
  final String roleName;
  final String roleDesc;
  final String roleStatus; // Active / Inactive (adjust to your actual values)
  final String roleCB; // Created By
  final DateTime roleCD; // Created Date
  final String roleMB; // Modified By
  final DateTime roleMD; // Modified Date

  const Role({
    required this.roleCode,
    required this.roleName,
    required this.roleDesc,
    required this.roleStatus,
    required this.roleCB,
    required this.roleCD,
    required this.roleMB,
    required this.roleMD,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleCode: json['roleCode'] ?? '',
      roleName: json['roleName'] ?? '',
      roleDesc: json['roleDesc'] ?? '',
      roleStatus: json['roleStatus'] ?? '',
      roleCB: json['roleCB'] ?? '',
      roleCD: DateTime.parse(json['roleCD']),
      roleMB: json['roleMB'] ?? '',
      roleMD: DateTime.parse(json['roleMD']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleCode': roleCode,
      'roleName': roleName,
      'roleDesc': roleDesc,
      'roleStatus': roleStatus,
      'roleCB': roleCB,
      'roleCD': roleCD.toIso8601String(),
      'roleMB': roleMB,
      'roleMD': roleMD.toIso8601String(),
    };
  }
}
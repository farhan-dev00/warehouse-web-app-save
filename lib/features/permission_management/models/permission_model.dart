/// A single module's access matrix — one row of a permission table.
class PermissionModel {
  final String moduleName;
  final List<bool> access; // aligned index-for-index with PermissionDummyData.roles

  const PermissionModel({
    required this.moduleName,
    required this.access,
  });
}
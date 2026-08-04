/// Domain model for a company RoleManagement.
class RoleManagement {
  final String name;
  final String manager;
  final int totalEmployees;
  final String description;

  const RoleManagement({
    required this.name,
    required this.manager,
    required this.totalEmployees,
    required this.description,
  });
}

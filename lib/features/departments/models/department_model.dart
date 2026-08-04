/// Domain model for a company department.
class Department {
  final String name;
  final String manager;
  final int totalEmployees;
  final String description;

  const Department({
    required this.name,
    required this.manager,
    required this.totalEmployees,
    required this.description,
  });
}

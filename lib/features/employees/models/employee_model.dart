/// Domain model for a single employee row.
class Employee {
  final String id;
  final String name;
  final String department;
  final String position;
  final String email;
  final String status; // Active / Inactive / On Leave
  final String avatarInitials;
  final String joinDate;

  const Employee({
    required this.id,
    required this.name,
    required this.department,
    required this.position,
    required this.email,
    required this.status,
    required this.avatarInitials,
    required this.joinDate,
  });
}

import 'employee_model.dart';

/// Generates a realistic dummy list of ~30 employees.
class EmployeeDummyData {
  EmployeeDummyData._();

  static const _firstNames = [
    'John', 'Sarah', 'Michael', 'Aisha', 'David', 'Emily', 'Wei Ling', 'Ahmad',
    'Priya', 'James', 'Nur', 'Kevin', 'Chloe', 'Daniel', 'Farah', 'Ryan',
    'Grace', 'Hassan', 'Melissa', 'Kenji', 'Olivia', 'Suresh', 'Hannah',
    'Zul', 'Natalie', 'Arjun', 'Sophia', 'Ben', 'Yasmin', 'Marcus',
  ];
  static const _lastNames = [
    'Tan', 'Lee', 'Rahman', 'Kumar', 'Wong', 'Ibrahim', 'Chong', 'Fernandez',
    'Lim', 'Ong', 'Abdullah', 'Chan', 'Singh', 'Yap', 'Hassan', 'Goh',
  ];
  static const _departments = [
    'Engineering', 'Marketing', 'Sales', 'Human Resource', 'Finance',
    'Operations', 'Customer Support', 'Design', 'Legal', 'IT',
  ];
  static const _positions = [
    'Software Engineer', 'Product Manager', 'HR Executive', 'Accountant',
    'Sales Executive', 'Marketing Specialist', 'UI/UX Designer',
    'Operations Analyst', 'Customer Support Lead', 'System Administrator',
  ];
  static const _statuses = ['Active', 'Active', 'Active', 'On Leave', 'Inactive'];

  static List<Employee> generate({int count = 30}) {
    return List.generate(count, (i) {
      final first = _firstNames[i % _firstNames.length];
      final last = _lastNames[(i * 3) % _lastNames.length];
      final name = '$first $last';
      final dept = _departments[i % _departments.length];
      final position = _positions[i % _positions.length];
      final status = _statuses[i % _statuses.length];
      final year = 2019 + (i % 6);
      final month = (i % 12) + 1;
      final day = (i % 27) + 1;

      return Employee(
        id: 'EMP${(1000 + i).toString()}',
        name: name,
        department: dept,
        position: position,
        email: '${first.toLowerCase()}.${last.toLowerCase()}@novahr.com',
        status: status,
        avatarInitials: '${first[0]}${last[0]}',
        joinDate: '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}',
      );
    });
  }
}

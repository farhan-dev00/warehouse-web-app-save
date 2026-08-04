import 'department_model.dart';

/// Generates dummy department data (10 departments).
class DepartmentDummyData {
  DepartmentDummyData._();

  static List<Department> generate() => const [
        Department(
          name: 'Engineering',
          manager: 'David Wong',
          totalEmployees: 42,
          description: 'Builds and maintains all product & platform software.',
        ),
        Department(
          name: 'Marketing',
          manager: 'Emily Chan',
          totalEmployees: 18,
          description: 'Owns brand, campaigns, and growth initiatives.',
        ),
        Department(
          name: 'Sales',
          manager: 'James Fernandez',
          totalEmployees: 26,
          description: 'Manages client relationships and revenue targets.',
        ),
        Department(
          name: 'Human Resource',
          manager: 'Aisha Rahman',
          totalEmployees: 9,
          description: 'Handles hiring, payroll, and employee wellbeing.',
        ),
        Department(
          name: 'Finance',
          manager: 'Kevin Lim',
          totalEmployees: 12,
          description: 'Oversees budgeting, accounting, and reporting.',
        ),
        Department(
          name: 'Operations',
          manager: 'Chloe Ong',
          totalEmployees: 21,
          description: 'Keeps day-to-day business operations running.',
        ),
        Department(
          name: 'Customer Support',
          manager: 'Hassan Ibrahim',
          totalEmployees: 15,
          description: 'Front-line support for customer issues & queries.',
        ),
        Department(
          name: 'Design',
          manager: 'Grace Tan',
          totalEmployees: 8,
          description: 'Product, brand, and UX/UI design.',
        ),
        Department(
          name: 'Legal',
          manager: 'Marcus Yap',
          totalEmployees: 5,
          description: 'Contracts, compliance, and corporate governance.',
        ),
        Department(
          name: 'IT',
          manager: 'Ryan Goh',
          totalEmployees: 11,
          description: 'Internal tooling, infra, and technical support.',
        ),
      ];
}

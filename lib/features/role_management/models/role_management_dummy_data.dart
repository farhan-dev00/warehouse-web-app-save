import 'role_management_model.dart';

/// Generates dummy department data (10 departments).
class RoleManagementDummyData {
  RoleManagementDummyData._();

  static List<RoleManagement> generate() => const [
        RoleManagement(
          name: 'Engineering',
          manager: 'David Wong',
          totalEmployees: 42,
          description: 'Builds and maintains all product & platform software.',
        ),
        RoleManagement(
          name: 'Marketing',
          manager: 'Emily Chan',
          totalEmployees: 18,
          description: 'Owns brand, campaigns, and growth initiatives.',
        ),
        RoleManagement(
          name: 'Sales',
          manager: 'James Fernandez',
          totalEmployees: 26,
          description: 'Manages client relationships and revenue targets.',
        ),
        RoleManagement(
          name: 'Human Resource',
          manager: 'Aisha Rahman',
          totalEmployees: 9,
          description: 'Handles hiring, payroll, and employee wellbeing.',
        ),
        RoleManagement(
          name: 'Finance',
          manager: 'Kevin Lim',
          totalEmployees: 12,
          description: 'Oversees budgeting, accounting, and reporting.',
        ),
        RoleManagement(
          name: 'Operations',
          manager: 'Chloe Ong',
          totalEmployees: 21,
          description: 'Keeps day-to-day business operations running.',
        ),
        RoleManagement(
          name: 'Customer Support',
          manager: 'Hassan Ibrahim',
          totalEmployees: 15,
          description: 'Front-line support for customer issues & queries.',
        ),
        RoleManagement(
          name: 'Design',
          manager: 'Grace Tan',
          totalEmployees: 8,
          description: 'Product, brand, and UX/UI design.',
        ),
        RoleManagement(
          name: 'Legal',
          manager: 'Marcus Yap',
          totalEmployees: 5,
          description: 'Contracts, compliance, and corporate governance.',
        ),
        RoleManagement(
          name: 'IT',
          manager: 'Ryan Goh',
          totalEmployees: 11,
          description: 'Internal tooling, infra, and technical support.',
        ),
      ];
}

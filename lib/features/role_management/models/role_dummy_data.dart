import 'role_model.dart';

/// Generates a realistic dummy list of ~30 roles.
class RoleDummyData {
  RoleDummyData._();

  static const _roleNames = [
    'Super Admin', 'System Admin', 'HR Manager', 'HR Executive',
    'Finance Manager', 'Accountant', 'Sales Manager', 'Sales Executive',
    'Marketing Manager', 'Marketing Executive', 'IT Manager',
    'Software Engineer', 'QA Engineer', 'Operations Manager',
    'Operations Executive', 'Customer Support Lead', 'Customer Support Agent',
    'Procurement Officer', 'Legal Advisor', 'Compliance Officer',
    'Warehouse Supervisor', 'Logistics Coordinator', 'Product Manager',
    'UI/UX Designer', 'Business Analyst', 'Project Manager',
    'Data Analyst', 'Auditor', 'Branch Manager', 'Receptionist',
  ];

  static const _descriptions = [
    'Full access to all system modules and settings.',
    'Manages user accounts, roles, and system configuration.',
    'Oversees hiring, employee records, and HR policies.',
    'Handles day-to-day HR administrative tasks.',
    'Manages budgets, financial reports, and approvals.',
    'Handles bookkeeping, invoices, and reconciliation.',
    'Oversees sales targets and team performance.',
    'Manages client accounts and closes sales deals.',
    'Plans and executes marketing campaigns.',
    'Supports content creation and campaign execution.',
    'Manages IT infrastructure and technical support.',
    'Develops and maintains application features.',
    'Tests and verifies application quality before release.',
    'Oversees daily operational workflows.',
    'Assists with operational tasks and reporting.',
    'Leads the customer support team.',
    'Handles customer inquiries and complaints.',
    'Manages vendor sourcing and purchase orders.',
    'Provides legal guidance and contract review.',
    'Ensures adherence to regulatory requirements.',
    'Supervises warehouse staff and inventory.',
    'Coordinates shipment and delivery schedules.',
    'Defines product roadmap and requirements.',
    'Designs user interfaces and experiences.',
    'Analyzes business processes and requirements.',
    'Plans and tracks project timelines and deliverables.',
    'Analyzes data to support business decisions.',
    'Reviews financial and operational records for accuracy.',
    'Oversees branch operations and staff.',
    'Handles front-desk and visitor management.',
  ];

  static const _statuses = ['Active', 'Active', 'Active', 'Inactive'];
  static const _users = ['admin', 'jtan', 'slee', 'system', 'mrahman'];

  static List<Role> generate({int count = 30}) {
    return List.generate(count, (i) {
      final name = _roleNames[i % _roleNames.length];
      final desc = _descriptions[i % _descriptions.length];
      final status = _statuses[i % _statuses.length];
      final createdBy = _users[i % _users.length];
      final modifiedBy = _users[(i + 2) % _users.length];

      final createdYear = 2019 + (i % 6);
      final createdMonth = (i % 12) + 1;
      final createdDay = (i % 27) + 1;
      final createdDate = DateTime(createdYear, createdMonth, createdDay);

      // Modified date is always on/after created date for realism.
      final modifiedDate = createdDate.add(Duration(days: (i * 17) % 400));

      return Role(
        roleCode: 'ROLE${(100 + i).toString()}',
        roleName: name,
        roleDesc: desc,
        roleStatus: status,
        roleCB: createdBy,
        roleCD: createdDate,
        roleMB: modifiedBy,
        roleMD: modifiedDate,
      );
    });
  }
}
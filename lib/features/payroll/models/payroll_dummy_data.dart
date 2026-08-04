import 'payroll_model.dart';

/// Generates dummy payroll records for the current pay period.
class PayrollDummyData {
  PayrollDummyData._();

  static const _names = [
    'John Tan', 'Sarah Lee', 'Michael Rahman', 'Aisha Kumar', 'David Wong',
    'Emily Ibrahim', 'Wei Ling Chong', 'Ahmad Fernandez', 'Priya Lim', 'James Ong',
    'Nur Abdullah', 'Kevin Chan', 'Chloe Singh', 'Daniel Yap', 'Farah Hassan',
  ];
  static const _departments = [
    'Engineering', 'Marketing', 'Sales', 'Human Resource', 'Finance',
  ];
  static const _statuses = ['Paid', 'Paid', 'Paid', 'Processing', 'Pending'];

  static List<PayrollRecord> generate() {
    return List.generate(_names.length, (i) {
      final basic = 3500.0 + (i * 275);
      final allowance = 200.0 + (i % 5) * 50;
      final deduction = 150.0 + (i % 4) * 40;
      final net = basic + allowance - deduction;

      return PayrollRecord(
        employeeName: _names[i],
        department: _departments[i % _departments.length],
        basicSalary: basic,
        allowance: allowance,
        deduction: deduction,
        netSalary: net,
        status: _statuses[i % _statuses.length],
      );
    });
  }
}

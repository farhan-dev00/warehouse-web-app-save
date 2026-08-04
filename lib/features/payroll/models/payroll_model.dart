/// A single employee's payroll record for the current period.
class PayrollRecord {
  final String employeeName;
  final String department;
  final double basicSalary;
  final double allowance;
  final double deduction;
  final double netSalary;
  final String status; // Paid / Processing / Pending

  const PayrollRecord({
    required this.employeeName,
    required this.department,
    required this.basicSalary,
    required this.allowance,
    required this.deduction,
    required this.netSalary,
    required this.status,
  });
}

/// A single leave request.
class LeaveRequest {
  final String employeeName;
  final String department;
  final String leaveType; // Annual / Sick / Emergency / Unpaid
  final String startDate;
  final String endDate;
  final int days;
  final String status; // Pending / Approved / Rejected
  final String reason;

  const LeaveRequest({
    required this.employeeName,
    required this.department,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.status,
    required this.reason,
  });
}

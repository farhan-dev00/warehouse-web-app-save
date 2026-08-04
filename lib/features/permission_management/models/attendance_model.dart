/// A single day's attendance record for one employee.
class AttendanceRecord {
  final String employeeName;
  final String department;
  final String date;
  final String checkIn;
  final String checkOut;
  final String workingHours;
  final String status; // Present / Late / Absent / On Leave

  const AttendanceRecord({
    required this.employeeName,
    required this.department,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.workingHours,
    required this.status,
  });
}

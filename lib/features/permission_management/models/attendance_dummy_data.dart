import 'attendance_model.dart';

/// Generates dummy attendance records for today's date across employees.
class AttendanceDummyData {
  AttendanceDummyData._();

  static const _names = [
    'John Tan', 'Sarah Lee', 'Michael Rahman', 'Aisha Kumar', 'David Wong',
    'Emily Ibrahim', 'Wei Ling Chong', 'Ahmad Fernandez', 'Priya Lim', 'James Ong',
    'Nur Abdullah', 'Kevin Chan', 'Chloe Singh', 'Daniel Yap', 'Farah Hassan',
    'Ryan Goh', 'Grace Tan', 'Hassan Lee', 'Melissa Rahman', 'Kenji Kumar',
  ];
  static const _departments = [
    'Engineering', 'Marketing', 'Sales', 'Human Resource', 'Finance',
  ];
  static const _statuses = ['Present', 'Present', 'Present', 'Late', 'Absent', 'On Leave'];

  static List<AttendanceRecord> generate() {
    return List.generate(_names.length, (i) {
      final status = _statuses[i % _statuses.length];
      final checkIn = status == 'Absent'
          ? '--'
          : status == 'Late'
              ? '09:4${i % 5}'
              : '08:${(50 + i) % 60 < 10 ? '0' : ''}${(50 + i) % 60}'.padLeft(5, '0');
      final checkOut = status == 'Absent' || status == 'On Leave' ? '--' : '18:0${i % 5}';
      final hours = status == 'Absent' || status == 'On Leave' ? '0h' : '${8 + (i % 2)}h ${(i * 7) % 60}m';

      return AttendanceRecord(
        employeeName: _names[i],
        department: _departments[i % _departments.length],
        date: '2026-08-03',
        checkIn: checkIn,
        checkOut: checkOut,
        workingHours: hours,
        status: status,
      );
    });
  }
}

import 'leave_model.dart';

/// Generates dummy leave request records.
class LeaveDummyData {
  LeaveDummyData._();

  static List<LeaveRequest> generate() => const [
        LeaveRequest(
          employeeName: 'John Tan',
          department: 'Engineering',
          leaveType: 'Annual',
          startDate: '2026-08-10',
          endDate: '2026-08-12',
          days: 3,
          status: 'Pending',
          reason: 'Family vacation',
        ),
        LeaveRequest(
          employeeName: 'Sarah Lee',
          department: 'Marketing',
          leaveType: 'Sick',
          startDate: '2026-08-04',
          endDate: '2026-08-04',
          days: 1,
          status: 'Approved',
          reason: 'Flu / fever',
        ),
        LeaveRequest(
          employeeName: 'Michael Rahman',
          department: 'Sales',
          leaveType: 'Emergency',
          startDate: '2026-08-02',
          endDate: '2026-08-03',
          days: 2,
          status: 'Approved',
          reason: 'Family emergency',
        ),
        LeaveRequest(
          employeeName: 'Aisha Kumar',
          department: 'Human Resource',
          leaveType: 'Annual',
          startDate: '2026-08-15',
          endDate: '2026-08-20',
          days: 6,
          status: 'Pending',
          reason: 'Overseas trip',
        ),
        LeaveRequest(
          employeeName: 'David Wong',
          department: 'Finance',
          leaveType: 'Unpaid',
          startDate: '2026-07-28',
          endDate: '2026-07-29',
          days: 2,
          status: 'Rejected',
          reason: 'Personal matters',
        ),
        LeaveRequest(
          employeeName: 'Emily Ibrahim',
          department: 'Operations',
          leaveType: 'Sick',
          startDate: '2026-08-05',
          endDate: '2026-08-06',
          days: 2,
          status: 'Pending',
          reason: 'Medical checkup',
        ),
        LeaveRequest(
          employeeName: 'Wei Ling Chong',
          department: 'Design',
          leaveType: 'Annual',
          startDate: '2026-08-18',
          endDate: '2026-08-18',
          days: 1,
          status: 'Approved',
          reason: 'Personal day',
        ),
        LeaveRequest(
          employeeName: 'Ahmad Fernandez',
          department: 'IT',
          leaveType: 'Sick',
          startDate: '2026-08-01',
          endDate: '2026-08-02',
          days: 2,
          status: 'Approved',
          reason: 'Recovering from surgery',
        ),
      ];

  /// Leave balance summary shown as cards at the top of the page.
  static Map<String, int> balanceSummary() => const {
        'Annual Leave': 14,
        'Sick Leave': 10,
        'Emergency Leave': 3,
        'Unpaid Leave': 0,
      };
}

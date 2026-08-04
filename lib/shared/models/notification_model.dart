/// A single dummy notification shown in the top bar popup.
class AppNotification {
  final String title;
  final String subtitle;
  final String timeAgo;
  final NotificationType type;

  const AppNotification({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.type,
  });

  static List<AppNotification> dummyList() => const [
        AppNotification(
          title: 'Leave request',
          subtitle: 'John Tan submitted a leave request.',
          timeAgo: '5m ago',
          type: NotificationType.leave,
        ),
        AppNotification(
          title: 'Payroll completed',
          subtitle: 'July payroll has been processed successfully.',
          timeAgo: '1h ago',
          type: NotificationType.payroll,
        ),
        AppNotification(
          title: 'New employee',
          subtitle: 'Aisha Rahman was registered in Marketing.',
          timeAgo: '3h ago',
          type: NotificationType.employee,
        ),
        AppNotification(
          title: 'Attendance alert',
          subtitle: '3 employees have not checked in today.',
          timeAgo: '6h ago',
          type: NotificationType.attendance,
        ),
      ];
}

enum NotificationType { leave, payroll, employee, attendance }

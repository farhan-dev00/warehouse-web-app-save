import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';

/// A single activity row shown on the dashboard.
class _Activity {
  final String employee;
  final String action;
  final String time;
  final String status;
  const _Activity(this.employee, this.action, this.time, this.status);
}

/// "Recent Activities" table on the dashboard — a feed of the latest
/// HR events across the company.
class RecentActivitiesTable extends StatelessWidget {
  const RecentActivitiesTable({super.key});

  static const _activities = [
    _Activity('John Tan', 'Submitted a leave request', '5m ago', 'Pending'),
    _Activity('Payroll System', 'July payroll processed', '1h ago', 'Completed'),
    _Activity('Aisha Rahman', 'Registered as new employee', '3h ago', 'Completed'),
    _Activity('Michael Rahman', 'Checked in late', '4h ago', 'Late'),
    _Activity('Sarah Lee', 'Leave request approved', '6h ago', 'Completed'),
    _Activity('David Wong', 'Updated department to Finance', '1d ago', 'Completed'),
  ];

  StatusChip _chip(String status) {
    switch (status) {
      case 'Completed':
        return StatusChip.success(status);
      case 'Late':
        return StatusChip.warning(status);
      default:
        return StatusChip.info(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _activities
          .map((a) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(Icons.person, size: 16, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.employee, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(a.action, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Text(a.time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    const SizedBox(width: 12),
                    _chip(a.status),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

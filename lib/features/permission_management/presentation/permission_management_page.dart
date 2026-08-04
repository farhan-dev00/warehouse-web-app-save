import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/summary_card.dart';
import '../models/attendance_dummy_data.dart';

/// Attendance page: summary cards + a calendar-style day strip + a table
/// of today's check-in / check-out records.
class PermissionManagementPage extends StatelessWidget {
  const PermissionManagementPage({super.key});

  StatusChip _statusChip(String status) {
    switch (status) {
      case 'Present':
        return StatusChip.success(status);
      case 'Late':
        return StatusChip.warning(status);
      case 'On Leave':
        return StatusChip.info(status);
      default:
        return StatusChip.danger(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final records = AttendanceDummyData.generate();
    final present = records.where((r) => r.status == 'Present').length;
    final late = records.where((r) => r.status == 'Late').length;
    final absent = records.where((r) => r.status == 'Absent').length;
    final onLeave = records.where((r) => r.status == 'On Leave').length;
    final columns = Responsive.gridColumns(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Attendance', subtitle: 'Today · 3 August 2026'),
          const SizedBox(height: AppSizes.spaceLg),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            mainAxisSpacing: AppSizes.spaceMd,
            crossAxisSpacing: AppSizes.spaceMd,
            childAspectRatio: 1.6,
            children: [
              SummaryCard(label: 'Present', value: '$present', icon: Icons.check_circle_outline, color: AppColors.success),
              SummaryCard(label: 'Late', value: '$late', icon: Icons.watch_later_outlined, color: AppColors.warning),
              SummaryCard(label: 'Absent', value: '$absent', icon: Icons.cancel_outlined, color: AppColors.danger),
              SummaryCard(label: 'On Leave', value: '$onLeave', icon: Icons.event_busy_outlined, color: AppColors.info),
            ],
          ),
          const SizedBox(height: AppSizes.spaceLg),
          _buildCalendarStrip(),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Today\'s Records', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: AppSizes.spaceMd),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(AppColors.background),
                    columns: const [
                      DataColumn(label: Text('Employee')),
                      DataColumn(label: Text('Department')),
                      DataColumn(label: Text('Check In')),
                      DataColumn(label: Text('Check Out')),
                      DataColumn(label: Text('Working Hours')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: records
                        .map((r) => DataRow(cells: [
                              DataCell(Text(r.employeeName)),
                              DataCell(Text(r.department)),
                              DataCell(Text(r.checkIn)),
                              DataCell(Text(r.checkOut)),
                              DataCell(Text(r.workingHours)),
                              DataCell(_statusChip(r.status)),
                            ]))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarStrip() {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return AppCard(
      child: SizedBox(
        height: 76,
        child: Row(
          children: List.generate(7, (i) {
            final isToday = i == 0; // Monday, matches "current date"
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primary : AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(days[i],
                        style: TextStyle(
                            fontSize: 12,
                            color: isToday ? Colors.white70 : AppColors.textSecondary)),
                    Text('${3 + i}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isToday ? Colors.white : AppColors.textPrimary)),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

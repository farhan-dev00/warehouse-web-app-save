import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/dialogs/action_dialog.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/summary_card.dart';
import '../models/leave_dummy_data.dart';
import '../models/leave_model.dart';

/// Leave management page: balance cards + a table of requests with
/// Approve / Reject actions, split by tab (All / Pending / Approved / Rejected).
class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _requests = LeaveDummyData.generate();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  StatusChip _statusChip(String status) {
    switch (status) {
      case 'Approved':
        return StatusChip.success(status);
      case 'Rejected':
        return StatusChip.danger(status);
      default:
        return StatusChip.warning(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final balances = LeaveDummyData.balanceSummary();
    final columns = Responsive.gridColumns(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Leave Management', subtitle: 'Requests & balances'),
          const SizedBox(height: AppSizes.spaceLg),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            mainAxisSpacing: AppSizes.spaceMd,
            crossAxisSpacing: AppSizes.spaceMd,
            childAspectRatio: 1.6,
            children: balances.entries
                .map((e) => SummaryCard(
                      label: e.key,
                      value: '${e.value} days',
                      icon: Icons.calendar_today_outlined,
                      color: AppColors.chartPalette[balances.keys.toList().indexOf(e.key) % AppColors.chartPalette.length],
                    ))
                .toList(),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Pending'),
                    Tab(text: 'Approved'),
                    Tab(text: 'Rejected'),
                  ],
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.spaceLg),
                  child: AnimatedBuilder(
                    animation: _tabController,
                    builder: (context, _) {
                      final filterStatus = switch (_tabController.index) {
                        1 => 'Pending',
                        2 => 'Approved',
                        3 => 'Rejected',
                        _ => null,
                      };
                      final items = filterStatus == null
                          ? _requests
                          : _requests.where((r) => r.status == filterStatus).toList();
                      return _buildTable(items);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(List<LeaveRequest> items) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(child: Text('No leave requests in this category.')),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.background),
        columns: const [
          DataColumn(label: Text('Employee')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('From')),
          DataColumn(label: Text('To')),
          DataColumn(label: Text('Days')),
          DataColumn(label: Text('Reason')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: items
            .map((r) => DataRow(cells: [
                  DataCell(Text(r.employeeName)),
                  DataCell(Text(r.leaveType)),
                  DataCell(Text(r.startDate)),
                  DataCell(Text(r.endDate)),
                  DataCell(Text('${r.days}')),
                  DataCell(SizedBox(width: 160, child: Text(r.reason, overflow: TextOverflow.ellipsis))),
                  DataCell(_statusChip(r.status)),
                  DataCell(
                    r.status == 'Pending'
                        ? Row(
                            children: [
                              IconButton(
                                tooltip: 'Approve',
                                icon: const Icon(Icons.check_circle_outline, color: AppColors.success, size: 20),
                                onPressed: () => showActionDialog(context,
                                    action: 'Approve leave for ${r.employeeName}'),
                              ),
                              IconButton(
                                tooltip: 'Reject',
                                icon: const Icon(Icons.cancel_outlined, color: AppColors.danger, size: 20),
                                onPressed: () => showActionDialog(context,
                                    action: 'Reject leave for ${r.employeeName}'),
                              ),
                            ],
                          )
                        : const Text('-', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                ]))
            .toList(),
      ),
    );
  }
}

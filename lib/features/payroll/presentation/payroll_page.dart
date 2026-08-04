import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/dialogs/action_dialog.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/summary_card.dart';
import '../models/payroll_dummy_data.dart';

/// Payroll page: totals summary + payroll table + "Generate Payroll" action.
class PayrollPage extends StatelessWidget {
  const PayrollPage({super.key});

  StatusChip _statusChip(String status) {
    switch (status) {
      case 'Paid':
        return StatusChip.success(status);
      case 'Processing':
        return StatusChip.info(status);
      default:
        return StatusChip.warning(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final records = PayrollDummyData.generate();
    final totalNet = records.fold<double>(0, (sum, r) => sum + r.netSalary);
    final paidCount = records.where((r) => r.status == 'Paid').length;
    final pendingCount = records.where((r) => r.status != 'Paid').length;
    final columns = Responsive.gridColumns(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Payroll',
            subtitle: 'Current pay period · August 2026',
            trailing: ElevatedButton.icon(
              onPressed: () => showActionDialog(context, action: 'Generate Payroll'),
              icon: const Icon(Icons.autorenew, size: 18),
              label: const Text('Generate Payroll'),
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            mainAxisSpacing: AppSizes.spaceMd,
            crossAxisSpacing: AppSizes.spaceMd,
            childAspectRatio: 1.6,
            children: [
              SummaryCard(
                label: 'Total Net Payroll',
                value: 'RM ${totalNet.toStringAsFixed(0)}',
                icon: Icons.account_balance_wallet_outlined,
                color: AppColors.primary,
              ),
              SummaryCard(
                label: 'Employees Paid',
                value: '$paidCount',
                icon: Icons.check_circle_outline,
                color: AppColors.success,
              ),
              SummaryCard(
                label: 'Pending Payments',
                value: '$pendingCount',
                icon: Icons.hourglass_bottom_outlined,
                color: AppColors.warning,
              ),
              SummaryCard(
                label: 'Average Salary',
                value: 'RM ${(totalNet / records.length).toStringAsFixed(0)}',
                icon: Icons.trending_up,
                color: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Payroll Records', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    OutlinedButton.icon(
                      onPressed: () => showActionDialog(context, action: 'Export Payroll'),
                      icon: const Icon(Icons.file_download_outlined, size: 18),
                      label: const Text('Export'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceMd),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(AppColors.background),
                    columns: const [
                      DataColumn(label: Text('Employee')),
                      DataColumn(label: Text('Department')),
                      DataColumn(label: Text('Basic Salary')),
                      DataColumn(label: Text('Allowance')),
                      DataColumn(label: Text('Deduction')),
                      DataColumn(label: Text('Net Salary')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: records
                        .map((r) => DataRow(cells: [
                              DataCell(Text(r.employeeName)),
                              DataCell(Text(r.department)),
                              DataCell(Text('RM ${r.basicSalary.toStringAsFixed(2)}')),
                              DataCell(Text('RM ${r.allowance.toStringAsFixed(2)}')),
                              DataCell(Text('RM ${r.deduction.toStringAsFixed(2)}')),
                              DataCell(Text('RM ${r.netSalary.toStringAsFixed(2)}',
                                  style: const TextStyle(fontWeight: FontWeight.w600))),
                              DataCell(_statusChip(r.status)),
                              DataCell(TextButton(
                                onPressed: () => showActionDialog(context,
                                    action: 'View payslip for ${r.employeeName}'),
                                child: const Text('Payslip'),
                              )),
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
}

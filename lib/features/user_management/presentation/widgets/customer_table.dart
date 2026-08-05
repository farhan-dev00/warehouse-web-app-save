import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/dialogs/action_dialog.dart';
import '../../../../shared/dialogs/confirm_dialog.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../models/customer_model.dart';

/// Data table rendering a page of customers with avatar, status chip and
/// row actions (view / edit / delete). Delete asks for confirmation first.
class CustomerTable extends StatelessWidget {
  final List<Customer> customers;

  const CustomerTable({super.key, required this.customers});

  StatusChip _statusChip(String status) {
    switch (status) {
      case 'Active':
        return StatusChip.success(status);
      case 'Inactive':
        return StatusChip.danger(status);
      default:
        return StatusChip.warning(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 28,
        headingRowColor: WidgetStateProperty.all(AppColors.background),
        columns: const [
          DataColumn(label: Text('Code')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Contact Number')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: customers.map((c) {
          return DataRow(cells: [
            DataCell(Text(c.custCode)),
            DataCell(Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    c.avatarInitials,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 10),
                Text(c.custName),
              ],
            )),
            DataCell(Text(c.custContactNo)),
            DataCell(_statusChip(c.custStatus)),
            DataCell(Row(
              children: [
                IconButton(
                  tooltip: 'View',
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  onPressed: () => showActionDialog(context, action: 'View ${c.custName}'),
                ),
                IconButton(
                  tooltip: 'Edit',
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => showActionDialog(context, action: 'Edit ${c.custName}'),
                ),
                IconButton(
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                  onPressed: () async {
                    final confirmed = await showConfirmDialog(
                      context,
                      title: 'Delete Customer',
                      message: 'Are you sure you want to delete ${c.custName}?',
                      confirmLabel: 'Delete',
                      isDestructive: true,
                    );
                    if (confirmed == true && context.mounted) {
                      showActionDialog(context, action: 'Delete ${c.custName}',
                          details: '${c.custName} has been removed (demo only, not persisted).');
                    }
                  },
                ),
              ],
            )),
          ]);
        }).toList(),
      ),
    );
  }
}
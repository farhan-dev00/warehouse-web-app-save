import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/dialogs/action_dialog.dart';
import '../../../../shared/dialogs/confirm_dialog.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../models/employee_model.dart';

/// Data table rendering a page of employees with photo, status chip and
/// row actions (view / edit / delete). Delete asks for confirmation first.
class EmployeeTable extends StatelessWidget {
  final List<Employee> employees;

  const EmployeeTable({super.key, required this.employees});

  StatusChip _statusChip(String status) {
    switch (status) {
      case 'Active':
        return StatusChip.success(status);
      case 'On Leave':
        return StatusChip.warning(status);
      default:
        return StatusChip.danger(status);
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
          DataColumn(label: Text('Employee')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Department')),
          DataColumn(label: Text('Position')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: employees.map((e) {
          return DataRow(cells: [
            DataCell(Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    e.avatarInitials,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 10),
                Text(e.name),
              ],
            )),
            DataCell(Text(e.id)),
            DataCell(Text(e.department)),
            DataCell(Text(e.position)),
            DataCell(Text(e.email)),
            DataCell(_statusChip(e.status)),
            DataCell(Row(
              children: [
                IconButton(
                  tooltip: 'View',
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  onPressed: () => showActionDialog(context, action: 'View ${e.name}'),
                ),
                IconButton(
                  tooltip: 'Edit',
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => showActionDialog(context, action: 'Edit ${e.name}'),
                ),
                IconButton(
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                  onPressed: () async {
                    final confirmed = await showConfirmDialog(
                      context,
                      title: 'Delete Employee',
                      message: 'Are you sure you want to delete ${e.name}?',
                      confirmLabel: 'Delete',
                      isDestructive: true,
                    );
                    if (confirmed == true && context.mounted) {
                      showActionDialog(context, action: 'Delete ${e.name}',
                          details: '${e.name} has been removed (demo only, not persisted).');
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

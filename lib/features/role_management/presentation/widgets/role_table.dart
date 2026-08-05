import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/dialogs/action_dialog.dart';
import '../../../../shared/dialogs/confirm_dialog.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../models/role_model.dart';

/// Data table rendering a page of roles with status chip and
/// row actions (view / edit / delete). Delete asks for confirmation first.
class RoleTable extends StatelessWidget {
  final List<Role> roles;

  const RoleTable({super.key, required this.roles});

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

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Created')),
          DataColumn(label: Text('Actions')),
        ],
        rows: roles.map((r) {
          return DataRow(cells: [
            DataCell(Text(r.roleCode)),
            DataCell(Text(r.roleName)),
            DataCell(SizedBox(
              width: 220,
              child: Text(
                r.roleDesc,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )),
            DataCell(_statusChip(r.roleStatus)),
            DataCell(Text(_formatDate(r.roleCD))),
            DataCell(Row(
              children: [
                IconButton(
                  tooltip: 'View',
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  onPressed: () => showActionDialog(context, action: 'View ${r.roleName}'),
                ),
                IconButton(
                  tooltip: 'Edit',
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => showActionDialog(context, action: 'Edit ${r.roleName}'),
                ),
                IconButton(
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                  onPressed: () async {
                    final confirmed = await showConfirmDialog(
                      context,
                      title: 'Delete Role',
                      message: 'Are you sure you want to delete ${r.roleName}?',
                      confirmLabel: 'Delete',
                      isDestructive: true,
                    );
                    if (confirmed == true && context.mounted) {
                      showActionDialog(context, action: 'Delete ${r.roleName}',
                          details: '${r.roleName} has been removed (demo only, not persisted).');
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
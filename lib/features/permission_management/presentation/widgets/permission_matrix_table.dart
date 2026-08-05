import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/permission_model.dart';

/// Read-only permission matrix: modules (rows) x roles (columns),
/// rendered as check/uncheck icons.
class PermissionMatrixTable extends StatelessWidget {
  final List<String> roles;
  final List<PermissionModel> modules;

  const PermissionMatrixTable({
    super.key,
    required this.roles,
    required this.modules,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        horizontalMargin: 16,
        headingRowColor: WidgetStateProperty.all(AppColors.background),
        columns: [
          const DataColumn(label: Text('Permission')),
          ...roles.map(
            (r) => DataColumn(
              label: SizedBox(
                width: 90,
                child: Text(
                  r,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
        rows: modules.map((m) {
          return DataRow(cells: [
            DataCell(Text(
              m.moduleName,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            )),
            ...m.access.map(
              (granted) => DataCell(
                Icon(
                  granted ? Icons.check_box : Icons.check_box_outline_blank,
                  size: 20,
                  color: granted ? AppColors.primary : Colors.grey.shade400,
                ),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }
}
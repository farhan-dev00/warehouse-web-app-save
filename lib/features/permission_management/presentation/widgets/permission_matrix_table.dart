import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/permission_model.dart';

/// Editable permission matrix: modules (rows) x roles (columns).
class PermissionMatrixTable extends StatefulWidget {
  final List<String> roles;
  final List<PermissionModel> modules;
  final void Function(int moduleIndex, int roleIndex, bool value) onToggle;

  const PermissionMatrixTable({
    super.key,
    required this.roles,
    required this.modules,
    required this.onToggle,
  });

  @override
  State<PermissionMatrixTable> createState() => _PermissionMatrixTableState();
}

class _PermissionMatrixTableState extends State<PermissionMatrixTable> {
  // Owns the scroll position for THIS table only, so the Scrollbar knows
  // exactly what it's attached to (rather than fighting the other table
  // for a shared PrimaryScrollController).
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Controllers hold onto resources — always dispose what you create.
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      // thumbVisibility: false (the default) means the bar is hidden until
      // hovered/dragged on web & desktop — exactly the hover behavior you want.
      // interactive: true lets the user also drag the thumb directly, not just scroll.
      interactive: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        // A bit of bottom padding stops the table content from sitting
        // flush under the scrollbar track when it appears.
        padding: const EdgeInsets.only(bottom: 8),
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 16,
          headingRowColor: WidgetStateProperty.all(AppColors.background),
          columns: [
            const DataColumn(label: Text('Permission')),
            ...widget.roles.map(
              (r) => DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text(
                    r,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
          rows: List.generate(widget.modules.length, (moduleIndex) {
            final module = widget.modules[moduleIndex];
            return DataRow(cells: [
              DataCell(Text(
                module.moduleName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              )),
              ...List.generate(widget.roles.length, (roleIndex) {
                final granted = module.access[roleIndex];
                return DataCell(
                  Checkbox(
                    value: granted,
                    activeColor: AppColors.primary,
                    onChanged: (value) =>
                        widget.onToggle(moduleIndex, roleIndex, value ?? false),
                  ),
                );
              }),
            ]);
          }),
        ),
      ),
    );
  }
}
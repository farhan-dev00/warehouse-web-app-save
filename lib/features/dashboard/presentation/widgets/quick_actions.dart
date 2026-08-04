import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/dialogs/action_dialog.dart';

class _QuickAction {
  final String label;
  final IconData icon;
  const _QuickAction(this.label, this.icon);
}

/// Row of quick-action buttons on the dashboard (Add Employee, Generate
/// Payroll, etc.) — each opens the shared dummy action dialog.
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  static const _actions = [
    _QuickAction('Add Employee', Icons.person_add_alt_1_outlined),
    _QuickAction('Generate Payroll', Icons.payments_outlined),
    _QuickAction('Approve Leave', Icons.event_available_outlined),
    _QuickAction('Download Report', Icons.download_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.spaceMd,
      runSpacing: AppSizes.spaceMd,
      children: _actions
          .map((a) => OutlinedButton.icon(
                onPressed: () => showActionDialog(context, action: a.label),
                icon: Icon(a.icon, size: 18, color: AppColors.primary),
                label: Text(a.label),
              ))
          .toList(),
    );
  }
}

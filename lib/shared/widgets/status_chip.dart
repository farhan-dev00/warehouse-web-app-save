import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// A small colored pill used for statuses like Active / Pending / Rejected.
/// Pass an explicit [color], or use one of the named constructors below.
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const StatusChip({super.key, required this.label, required this.color});

  factory StatusChip.success(String label) =>
      StatusChip(label: label, color: AppColors.success);
  factory StatusChip.warning(String label) =>
      StatusChip(label: label, color: AppColors.warning);
  factory StatusChip.danger(String label) =>
      StatusChip(label: label, color: AppColors.danger);
  factory StatusChip.info(String label) =>
      StatusChip(label: label, color: AppColors.info);
  factory StatusChip.neutral(String label) =>
      StatusChip(label: label, color: AppColors.textSecondary);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Simple "Page X of Y" control with prev/next buttons, used by every
/// paginated table (Employees, Payroll, Attendance, ...).
class PaginationBar extends StatelessWidget {
  final int currentPage; // 1-based
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int totalItems;
  final int pageSize;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.totalItems,
    required this.pageSize,
  });

  @override
  Widget build(BuildContext context) {
    final start = totalItems == 0 ? 0 : (currentPage - 1) * pageSize + 1;
    final end = (currentPage * pageSize).clamp(0, totalItems);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing $start-$end of $totalItems',
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
            ),
            Text('Page $currentPage of ${totalPages == 0 ? 1 : totalPages}'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed:
                  currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}

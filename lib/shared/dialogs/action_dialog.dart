import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';

/// Generic "this is a dummy action" dialog.
///
/// Since this project has no backend, every action button (Save, Delete,
/// Export, Approve, Generate Payroll, etc.) calls [showActionDialog] instead
/// of performing a real network call. Swap the body of this function later
/// for real API calls / navigation.
Future<void> showActionDialog(
  BuildContext context, {
  required String action,
  String? details,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      title: const Text('Action Triggered'),
      content: Text(
        details ?? 'You clicked "$action". This is a dummy action — '
            'no backend is connected in this demo.',
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

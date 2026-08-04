import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/dialogs/action_dialog.dart';

/// Settings > Notification tab: simple toggle preferences.
class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  final Map<String, bool> _prefs = {
    'Email me when a leave request is submitted': true,
    'Email me when payroll is processed': true,
    'Notify me about new employee registrations': false,
    'Weekly attendance summary email': true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._prefs.entries.map((e) => SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(e.key, style: const TextStyle(fontSize: 14)),
              value: e.value,
              onChanged: (v) => setState(() => _prefs[e.key] = v),
            )),
        const SizedBox(height: AppSizes.spaceLg),
        ElevatedButton(
          onPressed: () => showActionDialog(context, action: 'Save Notification Preferences'),
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}

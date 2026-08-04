import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/dialogs/action_dialog.dart';

/// Settings > Security tab: password change + 2FA toggle.
class SecurityTab extends StatefulWidget {
  const SecurityTab({super.key});

  @override
  State<SecurityTab> createState() => _SecurityTabState();
}

class _SecurityTabState extends State<SecurityTab> {
  bool _twoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Current Password')),
        const SizedBox(height: AppSizes.spaceMd),
        const TextField(obscureText: true, decoration: InputDecoration(labelText: 'New Password')),
        const SizedBox(height: AppSizes.spaceMd),
        const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Confirm New Password')),
        const SizedBox(height: AppSizes.spaceLg),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Two-Factor Authentication', style: TextStyle(fontSize: 14)),
          subtitle: const Text('Add an extra layer of security to your account.'),
          value: _twoFactorEnabled,
          onChanged: (v) => setState(() => _twoFactorEnabled = v),
        ),
        const SizedBox(height: AppSizes.spaceLg),
        ElevatedButton(
          onPressed: () => showActionDialog(context, action: 'Update Security Settings'),
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}

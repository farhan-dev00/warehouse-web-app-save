import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/dialogs/action_dialog.dart';

/// Settings > Profile tab: avatar + basic personal fields.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.primaryLight,
              child: Text('A', style: TextStyle(fontSize: 26, color: AppColors.primary, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: AppSizes.spaceLg),
            OutlinedButton.icon(
              onPressed: () => showActionDialog(context, action: 'Change Photo'),
              icon: const Icon(Icons.upload_outlined, size: 18),
              label: const Text('Change Photo'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceXl),
        Row(
          children: [
            Expanded(child: TextFormField(initialValue: 'Admin User', decoration: const InputDecoration(labelText: 'Full Name'))),
            const SizedBox(width: AppSizes.spaceMd),
            Expanded(child: TextFormField(initialValue: 'admin@novahr.com', decoration: const InputDecoration(labelText: 'Email'))),
          ],
        ),
        const SizedBox(height: AppSizes.spaceMd),
        Row(
          children: [
            Expanded(child: TextFormField(initialValue: '+60 12-345 6789', decoration: const InputDecoration(labelText: 'Phone'))),
            const SizedBox(width: AppSizes.spaceMd),
            Expanded(child: TextFormField(initialValue: 'Administrator', decoration: const InputDecoration(labelText: 'Role'), enabled: false)),
          ],
        ),
        const SizedBox(height: AppSizes.spaceLg),
        ElevatedButton(
          onPressed: () => showActionDialog(context, action: 'Save Profile'),
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}

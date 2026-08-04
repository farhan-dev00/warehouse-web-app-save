import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/dialogs/action_dialog.dart';

/// Settings > Company tab: company profile fields.
class CompanyTab extends StatelessWidget {
  const CompanyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: TextFormField(initialValue: 'NovaHR Sdn Bhd', decoration: const InputDecoration(labelText: 'Company Name'))),
            const SizedBox(width: AppSizes.spaceMd),
            Expanded(child: TextFormField(initialValue: '202601012345', decoration: const InputDecoration(labelText: 'Registration No.'))),
          ],
        ),
        const SizedBox(height: AppSizes.spaceMd),
        TextFormField(
          initialValue: 'Level 12, Menara Nova, Jalan Ampang, 50450 Kuala Lumpur',
          decoration: const InputDecoration(labelText: 'Company Address'),
        ),
        const SizedBox(height: AppSizes.spaceMd),
        Row(
          children: [
            Expanded(child: TextFormField(initialValue: 'Technology', decoration: const InputDecoration(labelText: 'Industry'))),
            const SizedBox(width: AppSizes.spaceMd),
            Expanded(child: TextFormField(initialValue: '150', decoration: const InputDecoration(labelText: 'Company Size'))),
          ],
        ),
        const SizedBox(height: AppSizes.spaceLg),
        ElevatedButton(
          onPressed: () => showActionDialog(context, action: 'Save Company Info'),
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/dialogs/action_dialog.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import '../models/department_dummy_data.dart';

/// Departments page: a responsive grid of department cards, each showing
/// manager, headcount, and quick actions.
class DepartmentsPage extends StatelessWidget {
  const DepartmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final departments = DepartmentDummyData.generate();
    final columns = Responsive.gridColumns(context).clamp(1, 3);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Departments',
            subtitle: '${departments.length} departments',
            trailing: ElevatedButton.icon(
              onPressed: () => showActionDialog(context, action: 'Add Department'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Department'),
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: departments.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: AppSizes.spaceMd,
              crossAxisSpacing: AppSizes.spaceMd,
              childAspectRatio: 1.7,
            ),
            itemBuilder: (context, i) {
              final d = departments[i];
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                          ),
                          child: const Icon(Icons.apartment_outlined, color: AppColors.primary),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (v) => showActionDialog(context, action: '$v ${d.name}'),
                          itemBuilder: (ctx) => const [
                            PopupMenuItem(value: 'Edit', child: Text('Edit')),
                            PopupMenuItem(value: 'Delete', child: Text('Delete')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceSm),
                    Text(d.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(d.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const Spacer(),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Manager: ${d.manager}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        Text('${d.totalEmployees} staff',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

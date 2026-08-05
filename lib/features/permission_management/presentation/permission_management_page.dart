import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/permission_management/models/permission_dummy_data.dart';
import 'package:warehouse_web_app/features/permission_management/models/permission_model.dart';
import 'package:warehouse_web_app/features/permission_management/presentation/widgets/permission_matrix_table.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/summary_card.dart';
import '../models/attendance_dummy_data.dart';

/// Attendance page: summary cards + a calendar-style day strip + a table
/// of today's check-in / check-out records.
class PermissionManagementPage extends StatelessWidget {
  const PermissionManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = PermissionDummyData.roles;
    final imsModules = PermissionDummyData.imsPermissions();
    final handheldModules = PermissionDummyData.handheldPermissions();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Permission Management',
            subtitle: 'Role-based access across IMS and Handheld modules',
          ),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'IMS Permission',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSizes.spaceMd),
                PermissionMatrixTable(roles: roles, modules: imsModules),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Handheld Permission',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSizes.spaceMd),
                PermissionMatrixTable(roles: roles, modules: handheldModules),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/permission_management/models/permission_dummy_data.dart';
import 'package:warehouse_web_app/features/permission_management/models/permission_model.dart';
import 'package:warehouse_web_app/features/permission_management/presentation/widgets/permission_matrix_table.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';

/// Attendance page: summary cards + a calendar-style day strip + a table
/// of today's check-in / check-out records.
class PermissionManagementPage extends StatefulWidget {
  const PermissionManagementPage({super.key});

  @override
  State<PermissionManagementPage> createState() => _PermissionManagementPageState();
}

class _PermissionManagementPageState extends State<PermissionManagementPage> {
  late List<PermissionModel> _imsModules;
  late List<PermissionModel> _handheldModules;

  @override
  void initState() {
    super.initState();
    // Runs ONCE, when this page is first built. This is where we make
    // our own working copy of the dummy data — this list is what the
    // checkboxes actually read from and write to from now on.
    _imsModules = PermissionDummyData.imsPermissions();
    _handheldModules = PermissionDummyData.handheldPermissions();
  }

  void _toggleIms(int moduleIndex, int roleIndex, bool value) {
    setState(() {
      _imsModules[moduleIndex].access[roleIndex] = value;
    });
  }

  void _toggleHandheld(int moduleIndex, int roleIndex, bool value) {
    setState(() {
      _handheldModules[moduleIndex].access[roleIndex] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final roles = PermissionDummyData.roles;

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
                const Text('IMS Permission',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSizes.spaceMd),
                PermissionMatrixTable(
                  roles: roles,
                  modules: _imsModules,
                  onToggle: _toggleIms,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Handheld Permission',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSizes.spaceMd),
                PermissionMatrixTable(
                  roles: roles,
                  modules: _handheldModules,
                  onToggle: _toggleHandheld,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
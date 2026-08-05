import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/role_management/models/role_dummy_data.dart';
import 'package:warehouse_web_app/features/role_management/models/role_model.dart';
import 'package:warehouse_web_app/features/role_management/presentation/widgets/role_table.dart';
import 'package:warehouse_web_app/shared/widgets/pagination_bar.dart';
import 'package:warehouse_web_app/shared/widgets/search_field.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/dialogs/action_dialog.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';

/// Role Management page: search, status filter, paginated table of roles.
class RoleManagementPage extends StatefulWidget {
  const RoleManagementPage({super.key});

  @override
  State<RoleManagementPage> createState() => _RoleManagementPageState();
}

class _RoleManagementPageState extends State<RoleManagementPage> {
  final List<Role> _allRoles = RoleDummyData.generate(count: 30);
  String _query = '';
  String _statusFilter = 'All';
  int _page = 1;
  static const _pageSize = 8;

  List<Role> get _filtered {
    return _allRoles.where((r) {
      final matchesQuery = _query.isEmpty ||
          r.roleName.toLowerCase().contains(_query.toLowerCase()) ||
          r.roleCode.toLowerCase().contains(_query.toLowerCase());
      final matchesStatus = _statusFilter == 'All' || r.roleStatus == _statusFilter;
      return matchesQuery && matchesStatus;
    }).toList();
  }

  List<Role> get _pageItems {
    final filtered = _filtered;
    final start = (_page - 1) * _pageSize;
    if (start >= filtered.length) return [];
    return filtered.skip(start).take(_pageSize).toList();
  }

  @override
  Widget build(BuildContext context) {
    final statuses = ['All', ...{for (final r in _allRoles) r.roleStatus}];
    final filteredCount = _filtered.length;
    final totalPages = (filteredCount / _pageSize).ceil();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Role Management',
            subtitle: '$filteredCount roles found',
            trailing: ElevatedButton.icon(
              onPressed: () => showActionDialog(context, action: 'Add Role'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Role'),
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSizes.spaceMd,
                  runSpacing: AppSizes.spaceSm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SearchField(
                      hint: 'Search by name or code...',
                      onChanged: (v) => setState(() {
                        _query = v;
                        _page = 1;
                      }),
                    ),
                    SizedBox(
                      width: 220,
                      child: DropdownButtonFormField<String>(
                        initialValue: _statusFilter,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.filter_list, size: 20),
                          isDense: true,
                        ),
                        items: statuses
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) => setState(() {
                          _statusFilter = v ?? 'All';
                          _page = 1;
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceLg),
                _pageItems.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: Text('No roles match your search.')),
                      )
                    : RoleTable(roles: _pageItems),
                const SizedBox(height: AppSizes.spaceMd),
                PaginationBar(
                  currentPage: _page,
                  totalPages: totalPages,
                  totalItems: filteredCount,
                  pageSize: _pageSize,
                  onPageChanged: (p) => setState(() => _page = p),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
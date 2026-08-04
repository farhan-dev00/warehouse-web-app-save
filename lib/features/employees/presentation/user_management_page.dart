import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/dialogs/action_dialog.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/pagination_bar.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/section_title.dart';
import '../models/employee_dummy_data.dart';
import '../models/employee_model.dart';
import 'widgets/employee_table.dart';

/// Employees listing page: search, department filter, paginated table.
class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final List<Employee> _allEmployees = EmployeeDummyData.generate(count: 30);
  String _query = '';
  String _departmentFilter = 'All';
  int _page = 1;
  static const _pageSize = 8;

  List<Employee> get _filtered {
    return _allEmployees.where((e) {
      final matchesQuery = _query.isEmpty ||
          e.name.toLowerCase().contains(_query.toLowerCase()) ||
          e.id.toLowerCase().contains(_query.toLowerCase());
      final matchesDept = _departmentFilter == 'All' || e.department == _departmentFilter;
      return matchesQuery && matchesDept;
    }).toList();
  }

  List<Employee> get _pageItems {
    final filtered = _filtered;
    final start = (_page - 1) * _pageSize;
    if (start >= filtered.length) return [];
    return filtered.skip(start).take(_pageSize).toList();
  }

  @override
  Widget build(BuildContext context) {
    final departments = ['All', ...{for (final e in _allEmployees) e.department}];
    final filteredCount = _filtered.length;
    final totalPages = (filteredCount / _pageSize).ceil();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Employees',
            subtitle: '$filteredCount employees found',
            trailing: Wrap(
              spacing: AppSizes.spaceSm,
              children: [
                OutlinedButton.icon(
                  onPressed: () => showActionDialog(context, action: 'Export'),
                  icon: const Icon(Icons.file_download_outlined, size: 18),
                  label: const Text('Export'),
                ),
                ElevatedButton.icon(
                  onPressed: () => showActionDialog(context, action: 'Add Employee'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Employee'),
                ),
              ],
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
                      hint: 'Search by name or ID...',
                      onChanged: (v) => setState(() {
                        _query = v;
                        _page = 1;
                      }),
                    ),
                    SizedBox(
                      width: 220,
                      child: DropdownButtonFormField<String>(
                        initialValue: _departmentFilter,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.filter_list, size: 20),
                          isDense: true,
                        ),
                        items: departments
                            .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                            .toList(),
                        onChanged: (v) => setState(() {
                          _departmentFilter = v ?? 'All';
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
                        child: Center(child: Text('No employees match your search.')),
                      )
                    : EmployeeTable(employees: _pageItems),
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

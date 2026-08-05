import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/user_management/models/customer_dummy_data.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/dialogs/action_dialog.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/pagination_bar.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/section_title.dart';
import '../models/customer_model.dart';
import 'widgets/customer_table.dart';

/// Customers listing page: search, status filter, paginated table.
class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final List<Customer> _allCustomers = CustomerDummyData.generate(count: 30);
  String _query = '';
  String _statusFilter = 'All';
  int _page = 1;
  static const _pageSize = 8;

  List<Customer> get _filtered {
    return _allCustomers.where((c) {
      final matchesQuery = _query.isEmpty ||
          c.custName.toLowerCase().contains(_query.toLowerCase()) ||
          c.custCode.toLowerCase().contains(_query.toLowerCase());
      final matchesStatus = _statusFilter == 'All' || c.custStatus == _statusFilter;
      return matchesQuery && matchesStatus;
    }).toList();
  }

  List<Customer> get _pageItems {
    final filtered = _filtered;
    final start = (_page - 1) * _pageSize;
    if (start >= filtered.length) return [];
    return filtered.skip(start).take(_pageSize).toList();
  }

  @override
  Widget build(BuildContext context) {
    final statuses = ['All', ...{for (final c in _allCustomers) c.custStatus}];
    final filteredCount = _filtered.length;
    final totalPages = (filteredCount / _pageSize).ceil();

    // Clamp the current page if filtering/searching reduced the page count.
    if (_page > totalPages && totalPages > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _page = totalPages);
      });
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Customers',
            subtitle: '$filteredCount customers found',
            trailing: Wrap(
              spacing: AppSizes.spaceSm,
              children: [
                OutlinedButton.icon(
                  onPressed: () => showActionDialog(context, action: 'Export'),
                  icon: const Icon(Icons.file_download_outlined, size: 18),
                  label: const Text('Export'),
                ),
                ElevatedButton.icon(
                  onPressed: () => showActionDialog(context, action: 'Add Customer'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Customer'),
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
                        child: Center(child: Text('No customers match your search.')),
                      )
                    : CustomerTable(customers: _pageItems),
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
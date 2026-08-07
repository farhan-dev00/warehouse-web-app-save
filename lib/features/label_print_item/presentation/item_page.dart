import 'package:flutter/material.dart';
import 'package:warehouse_web_app/core/constants/app_sizes.dart';
import 'package:warehouse_web_app/features/label_print_item/models/item_model.dart';
import 'package:warehouse_web_app/shared/dialogs/action_dialog.dart';
import 'package:warehouse_web_app/shared/widgets/app_card.dart';
import 'package:warehouse_web_app/shared/widgets/pagination_bar.dart';
import 'package:warehouse_web_app/shared/widgets/section_title.dart';
import '../models/item_dummy_data.dart';

/// Item page: Part No / Description listing table with pagination.
class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  // Swap this out for a real repository/API call once the backend is ready.
  final List<ItemModel> _allRecords = ItemDummyData.records;

  final ScrollController _horizontalController = ScrollController();
  final Set<String> _selectedPartNos = {};

  int _page = 1;
  static const _pageSize = 8;

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  List<ItemModel> get _pageItems {
    final start = (_page - 1) * _pageSize;
    if (start >= _allRecords.length) return [];
    return _allRecords.skip(start).take(_pageSize).toList();
  }

  @override
  Widget build(BuildContext context) {
    final records = _pageItems;
    final totalItems = _allRecords.length;
    final totalPages = (totalItems / _pageSize).ceil();

    // Clamp the current page if the record count ever shrinks.
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
            title: 'Item',
            subtitle: '$totalItems items found',
            trailing: Wrap(
              spacing: AppSizes.spaceSm,
              children: [
                ElevatedButton.icon(
                  onPressed: () => showActionDialog(context, action: 'Add Item'),
                  label: const Text('Add Item'),
                ),
                ElevatedButton.icon(
                  onPressed: _selectedPartNos.isEmpty
                      ? null
                      : () => showActionDialog(context, action: 'Print'),
                  label: const Text('Print'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- Table ----------
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Scrollbar(
                    controller: _horizontalController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    notificationPredicate: (notif) => true,
                    child: SingleChildScrollView(
                      controller: _horizontalController,
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 900),
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            Colors.grey.shade100,
                          ),
                          onSelectAll: (selectAll) {
                            setState(() {
                              if (selectAll ?? false) {
                                _selectedPartNos
                                  ..clear()
                                  ..addAll(records.map((r) => r.partNo));
                              } else {
                                _selectedPartNos.clear();
                              }
                            });
                          },
                          columns: const [
                            DataColumn(label: Text('Part No')),
                            DataColumn(label: Text('Description')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: records.isEmpty
                              ? [
                                  const DataRow(
                                    cells: [
                                      DataCell(Text('')),
                                      DataCell(
                                        Center(
                                          widthFactor: 1,
                                          child: Text('No records found'),
                                        ),
                                      ),
                                      DataCell(Text('')),
                                    ],
                                  ),
                                ]
                              : records.map((item) {
                                  final isSelected =
                                      _selectedPartNos.contains(item.partNo);
                                  return DataRow(
                                    selected: isSelected,
                                    onSelectChanged: (selected) {
                                      setState(() {
                                        if (selected ?? false) {
                                          _selectedPartNos.add(item.partNo);
                                        } else {
                                          _selectedPartNos.remove(item.partNo);
                                        }
                                      });
                                    },
                                    cells: [
                                      DataCell(Text(item.partNo)),
                                      DataCell(
                                        SizedBox(
                                          width: 400,
                                          child: Text(
                                            item.description,
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(
                                            Icons.print_outlined,
                                            size: 20,
                                          ),
                                          tooltip: 'Print',
                                          onPressed: () {
                                            // TODO: wire up print action.
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceMd),

                // ---------- Pagination ----------
                PaginationBar(
                  currentPage: _page,
                  totalPages: totalPages,
                  totalItems: totalItems,
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
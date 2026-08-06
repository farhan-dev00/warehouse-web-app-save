import 'package:flutter/material.dart';
import 'package:warehouse_web_app/core/constants/app_sizes.dart';
import 'package:warehouse_web_app/features/transfer_putaway/models/transfer_putaway_model.dart';
import 'package:warehouse_web_app/shared/dialogs/action_dialog.dart';
import 'package:warehouse_web_app/shared/widgets/pagination_bar.dart';
import 'package:warehouse_web_app/shared/widgets/section_title.dart';
import '../models/transfer_putaway_dummy_data.dart';

/// Transfer & Putaway page: Part No / Location listing table with search.
class TransferPutawayPage extends StatefulWidget {
  const TransferPutawayPage({super.key});

  @override
  State<TransferPutawayPage> createState() => _TransferPutawayPageState();
}

class _TransferPutawayPageState extends State<TransferPutawayPage> {
  // Swap this out for a real repository/API call once the backend is ready.
  final List<TransferPutawayModel> _allRecords =
      TransferPutawayDummyData.records;

  final ScrollController _horizontalController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  

  String _query = '';

  @override
  void dispose() {
    _horizontalController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  int _page = 1;
  static const _pageSize = 8;

  List<TransferPutawayModel> get _pageItems {
    final filtered = _filteredRecords;
    final start = (_page - 1) * _pageSize;
    if (start >= filtered.length) return [];
    return filtered.skip(start).take(_pageSize).toList();
  }

  List<TransferPutawayModel> get _filteredRecords {
    if (_query.trim().isEmpty) return _allRecords;
    final q = _query.trim().toLowerCase();
    return _allRecords.where((r) {
      return r.partNo.toLowerCase().contains(q) ||
          r.location.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final records = _pageItems;
    final filteredCount = _filteredRecords.length;
    final totalPages = (filteredCount / _pageSize).ceil();

    // Clamp the current page if filtering reduced the page count.
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
            // ---------- Search bar ----------
            SectionTitle(
              title: 'Transfer & Putaway',
              subtitle: '$filteredCount records found',
            trailing: Wrap(
              spacing: AppSizes.spaceSm,
              children: [
                ElevatedButton.icon(
                  onPressed: () => showActionDialog(context, action: 'Assign Location'),
                  label: const Text('Assign Location'),
                ),
                ElevatedButton.icon(
                  onPressed: () => showActionDialog(context, action: 'Add Location(s)'),
                  label: const Text('Add Location(s)'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
            SizedBox(
              width: 320,
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {
                  _query = value;
                  _page = 1;
                }),
                decoration: InputDecoration(
                  hintText: 'Search Part No or Location',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
        
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
                      columns: const [
                        DataColumn(label: Text('Part No')),
                        DataColumn(label: Text('Location')),
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
                                      child: Text('No matching records'),
                                    ),
                                  ),
                                  DataCell(Text('')),
                                ],
                              ),
                            ]
                          : records.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item.partNo)),
                                  DataCell(
                                    SizedBox(
                                      width: 400,
                                      child: Text(
                                        item.location,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  // Action intentionally left empty for
                                  // now — no action defined in the design.
                                  const DataCell(SizedBox()),
                                ],
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            PaginationBar(
              currentPage: _page,
              totalPages: totalPages,
              totalItems: filteredCount,
              pageSize: _pageSize,
              onPageChanged: (p) => setState(() => _page = p),
            ),
          ],
        ),
      );
  }
}
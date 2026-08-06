import 'package:flutter/material.dart';
import '../models/pick_pack_model.dart';
import '../models/pick_pack_dummy_data.dart';

class PickPackPage extends StatefulWidget {
  const PickPackPage({super.key});

  @override
  State<PickPackPage> createState() => _PickPackPageState();
}

class _PickPackPageState extends State<PickPackPage> {
  // Swap this out for a real repository/API call once the backend is ready.
  final List<PickPackModel> _records = PickPackDummyData.records;

  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'picked':
        return Colors.green.shade600;
      case 'pending':
        return Colors.orange.shade700;
      case 'cancelled':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _records.length;
    final showingFrom = total == 0 ? 0 : 1;
    final showingTo = total;

    return Scaffold(
      appBar: AppBar(title: const Text('Pick & Pack')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
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
                      constraints: const BoxConstraints(minWidth: 1200),
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.grey.shade100,
                        ),
                        columns: const [
                          DataColumn(label: Text('Pick List')),
                          DataColumn(label: Text('Document')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Customer Code')),
                          DataColumn(label: Text('Customer Name')),
                          DataColumn(label: Text('Ship Via')),
                          DataColumn(label: Text('Warehouse')),
                          DataColumn(label: Text('Remark')),
                          DataColumn(label: Text('Delivery Date')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: _records.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item.pickList)),
                              DataCell(Text(item.document)),
                              DataCell(
                                Text(
                                  item.status,
                                  style: TextStyle(
                                    color: _statusColor(item.status),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataCell(Text(item.customerCode)),
                              DataCell(
                                SizedBox(
                                  width: 220,
                                  child: Text(
                                    item.customerName,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              DataCell(Text(item.shipVia)),
                              DataCell(Text(item.warehouse)),
                              DataCell(Text(item.remark)),
                              DataCell(Text(item.deliveryDate)),
                              DataCell(
                                TextButton(
                                  onPressed: () {
                                    // TODO: wire up action (e.g. navigate to detail view).
                                  },
                                  child: const Text('View'),
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
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing $showingFrom to $showingTo of $total entries',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const Row(
                  children: [
                    TextButton(
                      onPressed: null, // wire up when real paging is added
                      child: Text('Previous'),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
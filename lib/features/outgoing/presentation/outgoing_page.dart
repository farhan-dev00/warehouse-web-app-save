import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/outgoing/models/outgoing_model.dart';
import 'package:warehouse_web_app/features/outgoing/presentation/outgoing_detail_page.dart';
import '../models/outgoing_dummy_data.dart';

/// Outgoing page: Delivery Order listing table.
class OutgoingPage extends StatefulWidget {
  const OutgoingPage({super.key});

  @override
  State<OutgoingPage> createState() => _OutgoingPageState();
}

class _OutgoingPageState extends State<OutgoingPage> {
  // Swap this out for a real repository/API call once the backend is ready.
  final List<OutgoingModel> _records = OutgoingDummyData.records;

  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
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
      appBar: AppBar(title: const Text('Outgoing')),
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
                      constraints: const BoxConstraints(minWidth: 1300),
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.grey.shade100,
                        ),
                        columns: const [
                          DataColumn(label: Text('Delivery Order No')),
                          DataColumn(label: Text('Order No')),
                          DataColumn(label: Text('Invoice No')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Delivery Order Date')),
                          DataColumn(label: Text('Bill To')),
                          DataColumn(label: Text('Deliver To')),
                          DataColumn(label: Text('Purchase Order')),
                          DataColumn(label: Text('Terms')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: _records.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item.deliveryOrderNo)),
                              DataCell(Text(item.orderNo)),
                              DataCell(Text(item.invoiceNo)),
                              DataCell(
                                Text(
                                  item.status,
                                  style: TextStyle(
                                    color: _statusColor(item.status),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataCell(Text(item.deliveryOrderDate)),
                              DataCell(
                                SizedBox(
                                  width: 200,
                                  child: Text(item.billTo, softWrap: true),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: 220,
                                  child: Text(item.deliverTo, softWrap: true),
                                ),
                              ),
                              DataCell(Text(item.purchaseOrder)),
                              DataCell(Text(item.terms)),
                              DataCell(
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const OutgoingDetailPage(),
                                      ),
                                    );
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
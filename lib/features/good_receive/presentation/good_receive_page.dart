import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/good_receive/models/good_receive_model.dart';
import '../models/good_receive_dummy_data.dart';

/// Payroll page: totals summary + payroll table + "Generate Payroll" action.
class GoodReceivePage extends StatefulWidget {
  const GoodReceivePage({super.key});
 
  @override
  State<GoodReceivePage> createState() => _GoodReceivePageState();
}
 
class _GoodReceivePageState extends State<GoodReceivePage> {
  // Swap this out for a real repository/API call once the backend is ready.
  final List<GoodReceiveModel> _records = GoodReceiveDummyData.records;
 
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
      appBar: AppBar(title: const Text('Good Receive')),
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
                          DataColumn(label: Text('Receiving No')),
                          DataColumn(label: Text('PO No')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Vendor Code')),
                          DataColumn(label: Text('Vendor Name')),
                          DataColumn(label: Text('Ship Via')),
                          DataColumn(label: Text('Waybill')),
                          DataColumn(label: Text('Shp Ref')),
                          DataColumn(label: Text('Category')),
                          DataColumn(label: Text('Order Type')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: _records.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item.receivingNo)),
                              DataCell(Text(item.poNo)),
                              DataCell(
                                Text(
                                  item.status,
                                  style: TextStyle(
                                    color: _statusColor(item.status),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataCell(Text(item.vendorCode)),
                              DataCell(Text(item.vendorName)),
                              DataCell(Text(item.shipVia)),
                              DataCell(Text(item.waybill)),
                              DataCell(Text(item.shpRef)),
                              DataCell(Text(item.category)),
                              DataCell(Text(item.orderType)),
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
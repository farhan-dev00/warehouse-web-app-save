import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/good_receive/models/details/good_receive_detail_model.dart';
import 'package:warehouse_web_app/features/good_receive/models/details/good_receive_item_model.dart';
import 'package:warehouse_web_app/features/good_receive/models/details/good_receive_transaction_dummy_data.dart';

/// Detail / transaction page for a single Good Receive record.
/// Shown when the user taps "View" on the Good Receive listing page.
class TransactionsGoodReceivePage extends StatefulWidget {
  const TransactionsGoodReceivePage({super.key});

  @override
  State<TransactionsGoodReceivePage> createState() =>
      _TransactionsGoodReceivePageState();
}

class _TransactionsGoodReceivePageState
    extends State<TransactionsGoodReceivePage> {
  // Swap these out for real repository/API calls once the backend is ready.
  final GoodReceiveDetailModel _header = GoodReceiveTransactionDummyData.header;
  final List<GoodReceiveItemModel> _items =
      GoodReceiveTransactionDummyData.items;
  final int _noOfItemRcv = GoodReceiveTransactionDummyData.noOfItemRcv;
  final int _totalQtyRcv = GoodReceiveTransactionDummyData.totalQtyRcv;

  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  double get _totalQty =>
      _items.fold(0, (sum, item) => sum + item.qtyRcv).toDouble();
  double get _totalItemCostSum =>
      _items.fold(0.0, (sum, item) => sum + item.totalItemCost);
  double get _totalTaxSum => _items.fold(0.0, (sum, item) => sum + item.tax);
  double get _totalCostSum =>
      _items.fold(0.0, (sum, item) => sum + item.totalCost);

  static String _formatNumber(double value, int decimals) {
    final fixed = value.toStringAsFixed(decimals);
    final parts = fixed.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? '.${parts[1]}' : '';

    final reversedDigits = intPart.split('').reversed.toList();
    final buffer = StringBuffer();
    for (var i = 0; i < reversedDigits.length; i++) {
      buffer.write(reversedDigits[i]);
      if ((i + 1) % 3 == 0 && i + 1 != reversedDigits.length) {
        buffer.write(',');
      }
    }
    final formattedInt = buffer.toString().split('').reversed.join();
    return '$formattedInt$decPart';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Good Receive Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- Upper panel: header summary ----------
                  _buildHeaderPanel(),

                  const SizedBox(height: 20),
                  const Divider(thickness: 1, height: 1),
                  const SizedBox(height: 20),

                  // ---------- Lower panel: item details ----------
                  _buildItemDetailsPanel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderPanel() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;

        final leftFields = [
          _ReadOnlyField(label: 'Receiving No.', value: _header.receivingNo),
          _ReadOnlyField(label: 'PO No.', value: _header.poNo),
          _ReadOnlyField(label: 'Vendor Code', value: _header.vendorCode),
          _ReadOnlyField(label: 'Vendor Name', value: _header.vendorName),
          _ReadOnlyField(label: 'Shp Ref', value: _header.shpRef),
          _ReadOnlyField(label: 'Ship Via', value: _header.shipVia),
          _ReadOnlyField(label: 'Waybill', value: _header.waybill),
          _ReadOnlyField(
            label: 'No. of Boxes:',
            value: _header.noOfBoxes.toString(),
            compact: true,
          ),
        ];

        final rightFields = [
          _ReadOnlyField(label: 'PO Created Date', value: _header.poCreatedBy),
          _ReadOnlyField(label: 'Rcv Date', value: _header.rcvDate),
          _ReadOnlyField(label: 'ETA Date', value: _header.etaDate),
          _ReadOnlyField(label: 'Category Type', value: _header.categoryType),
          _ReadOnlyField(label: 'Order Type :', value: _header.orderType),
        ];

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [...leftFields, ...rightFields],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: leftFields,
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rightFields,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItemDetailsPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Item Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Scrollbar(
            controller: _horizontalController,
            thumbVisibility: true,
            trackVisibility: true,
            notificationPredicate: (notif) => true,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 1500),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    Colors.grey.shade100,
                  ),
                  columns: const [
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Part Number')),
                    DataColumn(label: Text('Vendor Part Number')),
                    DataColumn(label: Text('Description/\nProject Name')),
                    DataColumn(label: Text('Rcv Price (RM)')),
                    DataColumn(label: Text('Rcv Price F (RM)')),
                    DataColumn(label: Text('PO Price (RM)')),
                    DataColumn(label: Text('PO Price F (RM)')),
                    DataColumn(label: Text('Qty Rcv')),
                    DataColumn(label: Text('UM')),
                    DataColumn(label: Text('Total Item Cost')),
                    DataColumn(label: Text('Tax (RM)')),
                    DataColumn(label: Text('Total Cost (RM)')),
                    DataColumn(label: Text('Received On')),
                    DataColumn(label: Text('Received By')),
                  ],
                  rows: [
                    ..._items.map((row) {
                      return DataRow(
                        cells: [
                          DataCell(Text(row.item.toString())),
                          DataCell(Text(row.partNumber)),
                          DataCell(Text(row.vendorPartNumber)),
                          DataCell(
                            SizedBox(
                              width: 220,
                              child: Text(row.description, softWrap: true),
                            ),
                          ),
                          DataCell(Text(_formatNumber(row.rcvPrice, 6))),
                          DataCell(Text(_formatNumber(row.rcvPriceF, 6))),
                          DataCell(Text(_formatNumber(row.poPrice, 6))),
                          DataCell(Text(_formatNumber(row.poPriceF, 6))),
                          DataCell(Text(row.qtyRcv.toString())),
                          DataCell(Text(row.um)),
                          DataCell(Text(_formatNumber(row.totalItemCost, 6))),
                          DataCell(Text(_formatNumber(row.tax, 2))),
                          DataCell(Text(_formatNumber(row.totalCost, 6))),
                          DataCell(
                            Text(
                              row.receivedOn,
                              style: TextStyle(color: Colors.green.shade600),
                            ),
                          ),
                          DataCell(
                            Text(
                              row.receivedBy,
                              style: TextStyle(color: Colors.green.shade600),
                            ),
                          ),
                        ],
                      );
                    }),
                    // ---- Totals row ----
                    DataRow(
                      cells: [
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(
                          Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataCell(
                          Text(
                            _formatNumber(_totalQty, 0),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const DataCell(SizedBox()),
                        DataCell(
                          Text(
                            _formatNumber(_totalItemCostSum, 2),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            _formatNumber(_totalTaxSum, 0),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            _formatNumber(_totalCostSum, 6),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 40,
          runSpacing: 12,
          children: [
            _ReadOnlyField(
              label: 'No. of Item Rcv',
              value: _noOfItemRcv.toString(),
              compact: true,
            ),
            _ReadOnlyField(
              label: 'Total Qty Rcv',
              value: _totalQtyRcv.toString(),
              compact: true,
            ),
          ],
        ),
      ],
    );
  }
}

/// A label + greyed-out read-only value box, matching the enterprise
/// "form summary" style used across the transaction detail pages.
class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final bool compact;

  const _ReadOnlyField({
    required this.label,
    required this.value,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: compact ? 100 : 260,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                value,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
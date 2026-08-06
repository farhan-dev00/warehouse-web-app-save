import 'package:flutter/material.dart';
import 'package:warehouse_web_app/core/constants/app_colors.dart';
import 'package:warehouse_web_app/features/pick_pack/models/details/pick_pack_detail_model.dart';
import 'package:warehouse_web_app/features/pick_pack/models/details/pick_pack_item_model.dart';
import 'package:warehouse_web_app/features/pick_pack/models/details/pick_pack_transaction_dummy_data.dart';

/// Detail / transaction page for a single Pick & Pack record.
/// Shown when the user taps "View" on the Pick & Pack listing page.
class TransactionsPickPackPage extends StatefulWidget {
  const TransactionsPickPackPage({super.key});

  @override
  State<TransactionsPickPackPage> createState() =>
      _TransactionsPickPackPageState();
}

class _TransactionsPickPackPageState extends State<TransactionsPickPackPage> {
  // Swap these out for real repository/API calls once the backend is ready.
  final PickPackDetailModel _header = PickPackTransactionDummyData.header;
  final List<PickPackItemModel> _items = PickPackTransactionDummyData.items;

  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick & Pack Details'),
        automaticallyImplyLeading: false,),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.accentText,
        label: const Text(
          'BACK',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
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
          _ReadOnlyField(label: 'Pick List', value: _header.pickList),
          _ReadOnlyField(label: 'Document', value: _header.document),
          _ReadOnlyField(label: 'Customer Code', value: _header.customerCode),
          _ReadOnlyField(label: 'Customer Name', value: _header.customerName),
        ];

        final rightFields = [
          _ReadOnlyField(
            label: 'Pick List Created Date',
            value: _header.pickListCreatedBy,
          ),
          _ReadOnlyField(label: 'Ship Via', value: _header.shipVia),
          _ReadOnlyField(label: 'Warehouse', value: _header.warehouse),
          _ReadOnlyField(label: 'Remark', value: _header.remark),
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
                constraints: const BoxConstraints(minWidth: 1400),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    Colors.grey.shade100,
                  ),
                  columns: const [
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Part Number')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Bin')),
                    DataColumn(label: Text('Bal. After Pick')),
                    DataColumn(label: Text('To Pick')),
                    DataColumn(label: Text('Picked')),
                    DataColumn(label: Text('Checked')),
                    DataColumn(label: Text('SN')),
                    DataColumn(label: Text('Reprint')),
                    DataColumn(label: Text('Picked & Packed On')),
                    DataColumn(label: Text('Picked & Packed By')),
                    DataColumn(label: Text('Checked On')),
                    DataColumn(label: Text('Checked By')),
                  ],
                  rows: _items.map((row) {
                    return DataRow(
                      cells: [
                        DataCell(Text(row.item.toString())),
                        DataCell(Text(row.partNumber)),
                        DataCell(
                          SizedBox(
                            width: 200,
                            child: Text(row.description, softWrap: true),
                          ),
                        ),
                        DataCell(Text(row.bin)),
                        DataCell(Text(row.balAfterPick.toString())),
                        DataCell(Text(row.toPick.toString())),
                        DataCell(
                          Text(
                            row.picked.toString(),
                            style: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.checked.toString(),
                            style: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(Text(row.sn)),
                        DataCell(Text(row.reprint)),
                        DataCell(
                          Text(
                            row.pickedPackedOn,
                            style: TextStyle(color: Colors.green.shade600),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.pickedPackedBy,
                            style: TextStyle(color: Colors.green.shade600),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.checkedOn,
                            style: TextStyle(color: Colors.green.shade600),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.checkedBy,
                            style: TextStyle(color: Colors.green.shade600),
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
      ],
    );
  }
}

/// A label + greyed-out read-only value box, matching the enterprise
/// "form summary" style used across the transaction detail pages.
class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
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
            width: 260,
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
import 'package:flutter/material.dart';
import 'package:warehouse_web_app/features/outgoing/models/details/outgoing_detail_model.dart';
import 'package:warehouse_web_app/features/outgoing/models/details/outgoing_item_model.dart';
import 'package:warehouse_web_app/features/outgoing/models/details/outgoing_party_model.dart';
import 'package:warehouse_web_app/features/outgoing/models/details/outgoing_transaction_dummy_data.dart';

/// Detail / transaction page for a single Outgoing (Delivery Order) record.
/// Shown when the user taps "View" on the Outgoing listing page.
class OutgoingDetailPage extends StatefulWidget {
  const OutgoingDetailPage({super.key});

  @override
  State<OutgoingDetailPage> createState() => _OutgoingDetailPageState();
}

class _OutgoingDetailPageState extends State<OutgoingDetailPage> {
  static const Color _accent = Color(0xFFFDB553);

  // Swap these out for real repository/API calls once the backend is ready.
  final OutgoingDetailModel _header = OutgoingTransactionDummyData.header;
  final List<OutgoingItemModel> _items = OutgoingTransactionDummyData.items;

  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outgoing Details'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: _accent,
        foregroundColor: Colors.black87,
        label: const Text('BACK', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  // ---------- Top panel: order/shipping summary ----------
                  _buildHeaderPanel(),

                  const SizedBox(height: 20),
                  const Divider(thickness: 1, height: 1),
                  const SizedBox(height: 20),

                  // ---------- Middle panel: Bill To / Deliver To ----------
                  _buildPartiesPanel(),

                  const SizedBox(height: 20),
                  const Divider(thickness: 1, height: 1),
                  const SizedBox(height: 20),

                  // ---------- Bottom panel: item details ----------
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
          _ReadOnlyField(label: 'Date', value: _header.date),
          _ReadOnlyField(label: 'Order No', value: _header.orderNo),
          _ReadOnlyField(label: 'D/O No', value: _header.doNo),
          _ReadOnlyField(label: 'Invoice No', value: _header.invoiceNo),
          _ReadOnlyField(label: 'Purchase Order', value: _header.purchaseOrder),
          _ReadOnlyField(label: 'Sales Person', value: _header.salesPerson),
        ];

        final rightFields = [
          _ReadOnlyField(label: 'Account No', value: _header.accountNo),
          _ReadOnlyField(label: 'Old Account No', value: _header.oldAccountNo),
          _ReadOnlyField(label: 'Ship Via', value: _header.shipVia),
          _ReadOnlyField(label: 'Terms', value: _header.terms),
          _ReadOnlyField(label: 'Ship Date', value: _header.shipDate),
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

  Widget _buildPartiesPanel() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;

        final billTo = _PartyBlock(title: 'Bill To', party: _header.billTo);
        final deliverTo = _PartyBlock(title: 'Deliver To', party: _header.deliverTo);

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              billTo,
              const SizedBox(height: 24),
              deliverTo,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: billTo),
            const SizedBox(width: 40),
            Expanded(child: deliverTo),
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
                constraints: const BoxConstraints(minWidth: 1300),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    Colors.grey.shade100,
                  ),
                  columns: const [
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Quantity Ordered')),
                    DataColumn(label: Text('Quantity Delivered')),
                    DataColumn(label: Text('Quantity Back Order')),
                    DataColumn(label: Text('Part No')),
                    DataColumn(label: Text('Serial No')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Checked On')),
                    DataColumn(label: Text('Checked By')),
                  ],
                  rows: _items.map((row) {
                    return DataRow(
                      cells: [
                        DataCell(Text(row.item.toString())),
                        DataCell(Text(row.quantityOrdered.toString())),
                        DataCell(Text(row.quantityDelivered.toString())),
                        DataCell(Text(row.quantityBackOrder.toString())),
                        DataCell(Text(row.partNo)),
                        DataCell(Text(row.serialNo)),
                        DataCell(
                          SizedBox(
                            width: 260,
                            child: Text(row.description, softWrap: true),
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

/// Renders a "Bill To" / "Deliver To" block: bold party name, muted
/// multi-line address, then Attn / Tel read-only fields.
class _PartyBlock extends StatelessWidget {
  final String title;
  final OutgoingPartyModel party;

  const _PartyBlock({required this.title, required this.party});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Text(
          party.name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        for (final line in party.addressLines)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              line,
              style: TextStyle(fontSize: 13, color: Colors.blueGrey.shade300),
            ),
          ),
        const SizedBox(height: 12),
        _ReadOnlyField(label: 'Attn', value: party.attn),
        _ReadOnlyField(label: 'Tel', value: party.tel),
      ],
    );
  }
}

/// A label + greyed-out read-only value box, matching the enterprise
/// "form summary" style used across the transaction detail pages.
class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyField({required this.label, required this.value});

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
import 'outgoing_party_model.dart';

/// Header information for a single Outgoing (Delivery Order) transaction
/// (the read-only summary panel + Bill To / Deliver To panel at the top of
/// the detail page).
class OutgoingDetailModel {
  final String date;
  final String orderNo;
  final String doNo;
  final String invoiceNo;
  final String purchaseOrder;
  final String salesPerson;

  final String accountNo;
  final String oldAccountNo;
  final String shipVia;
  final String terms;
  final String shipDate;

  final OutgoingPartyModel billTo;
  final OutgoingPartyModel deliverTo;

  const OutgoingDetailModel({
    required this.date,
    required this.orderNo,
    required this.doNo,
    required this.invoiceNo,
    required this.purchaseOrder,
    required this.salesPerson,
    required this.accountNo,
    required this.oldAccountNo,
    required this.shipVia,
    required this.terms,
    required this.shipDate,
    required this.billTo,
    required this.deliverTo,
  });
}
/// Represents a single row in the Outgoing (Delivery Order) listing table.
class OutgoingModel {
  final String deliveryOrderNo;
  final String orderNo;
  final String invoiceNo;
  final String status;
  final String deliveryOrderDate;
  final String billTo;
  final String deliverTo;
  final String purchaseOrder;
  final String terms;

  const OutgoingModel({
    required this.deliveryOrderNo,
    required this.orderNo,
    required this.invoiceNo,
    required this.status,
    required this.deliveryOrderDate,
    required this.billTo,
    required this.deliverTo,
    required this.purchaseOrder,
    required this.terms,
  });
}
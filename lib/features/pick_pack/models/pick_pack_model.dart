/// Represents a single row in the Pick & Pack listing table.
class PickPackModel {
  final String pickList;
  final String document;
  final String status;
  final String customerCode;
  final String customerName;
  final String shipVia;
  final String warehouse;
  final String remark;
  final String deliveryDate;
 
  const PickPackModel({
    required this.pickList,
    required this.document,
    required this.status,
    required this.customerCode,
    required this.customerName,
    required this.shipVia,
    required this.warehouse,
    this.remark = '',
    required this.deliveryDate,
  });
}
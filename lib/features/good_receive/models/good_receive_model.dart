/// Represents a single row in the Good Receive listing table.
class GoodReceiveModel {
  final String receivingNo;
  final String poNo;
  final String status;
  final String vendorCode;
  final String vendorName;
  final String shipVia;
  final String waybill;
  final String shpRef;
  final String category;
  final String orderType;
 
  const GoodReceiveModel({
    required this.receivingNo,
    required this.poNo,
    required this.status,
    required this.vendorCode,
    required this.vendorName,
    required this.shipVia,
    required this.waybill,
    required this.shpRef,
    required this.category,
    required this.orderType,
  });
}
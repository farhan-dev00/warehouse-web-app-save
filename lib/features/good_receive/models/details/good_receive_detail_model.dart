/// Header information for a single Good Receive transaction
/// (the read-only summary panel at the top of the detail page).
class GoodReceiveDetailModel {
  final String receivingNo;
  final String poNo;
  final String vendorCode;
  final String vendorName;
  final String shpRef;
  final String shipVia;
  final String waybill;
  final int noOfBoxes;

  final String poCreatedBy;
  final String rcvDate;
  final String etaDate;
  final String categoryType;
  final String orderType;

  const GoodReceiveDetailModel({
    required this.receivingNo,
    required this.poNo,
    required this.vendorCode,
    required this.vendorName,
    required this.shpRef,
    required this.shipVia,
    required this.waybill,
    required this.noOfBoxes,
    required this.poCreatedBy,
    required this.rcvDate,
    required this.etaDate,
    required this.categoryType,
    required this.orderType,
  });
}
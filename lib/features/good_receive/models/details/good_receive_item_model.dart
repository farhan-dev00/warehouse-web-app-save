/// A single line item row in the Item Details table of a Good Receive transaction.
class GoodReceiveItemModel {
  final int item;
  final String partNumber;
  final String vendorPartNumber;
  final String description;
  final double rcvPrice;
  final double rcvPriceF;
  final double poPrice;
  final double poPriceF;
  final int qtyRcv;
  final String um;
  final double totalItemCost;
  final double tax;
  final double totalCost;
  final String receivedOn;
  final String receivedBy;

  const GoodReceiveItemModel({
    required this.item,
    required this.partNumber,
    required this.vendorPartNumber,
    required this.description,
    required this.rcvPrice,
    required this.rcvPriceF,
    required this.poPrice,
    required this.poPriceF,
    required this.qtyRcv,
    required this.um,
    required this.totalItemCost,
    required this.tax,
    required this.totalCost,
    required this.receivedOn,
    required this.receivedBy,
  });
}
/// A single line item row in the Item Details table of an Outgoing transaction.
class OutgoingItemModel {
  final int item;
  final int quantityOrdered;
  final int quantityDelivered;
  final int quantityBackOrder;
  final String partNo;
  final String serialNo;
  final String description;
  final String checkedOn;
  final String checkedBy;

  const OutgoingItemModel({
    required this.item,
    required this.quantityOrdered,
    required this.quantityDelivered,
    required this.quantityBackOrder,
    required this.partNo,
    required this.serialNo,
    required this.description,
    required this.checkedOn,
    required this.checkedBy,
  });
}
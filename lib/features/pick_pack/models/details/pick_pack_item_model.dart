/// A single line item row in the Item Details table of a Pick & Pack transaction.
class PickPackItemModel {
  final int item;
  final String partNumber;
  final String description;
  final String bin;
  final int balAfterPick;
  final int toPick;
  final int picked;
  final int checked;
  final String sn;
  final String reprint;
  final String pickedPackedOn;
  final String pickedPackedBy;
  final String checkedOn;
  final String checkedBy;

  const PickPackItemModel({
    required this.item,
    required this.partNumber,
    required this.description,
    required this.bin,
    required this.balAfterPick,
    required this.toPick,
    required this.picked,
    required this.checked,
    required this.sn,
    required this.reprint,
    required this.pickedPackedOn,
    required this.pickedPackedBy,
    required this.checkedOn,
    required this.checkedBy,
  });
}
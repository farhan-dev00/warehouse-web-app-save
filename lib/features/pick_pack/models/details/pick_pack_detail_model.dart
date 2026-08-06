/// Header information for a single Pick & Pack transaction
/// (the read-only summary panel at the top of the detail page).
class PickPackDetailModel {
  final String pickList;
  final String document;
  final String customerCode;
  final String customerName;

  final String pickListCreatedBy;
  final String shipVia;
  final String warehouse;
  final String remark;

  const PickPackDetailModel({
    required this.pickList,
    required this.document,
    required this.customerCode,
    required this.customerName,
    required this.pickListCreatedBy,
    required this.shipVia,
    required this.warehouse,
    this.remark = '',
  });
}
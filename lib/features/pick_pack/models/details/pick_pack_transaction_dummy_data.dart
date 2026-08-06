import 'pick_pack_detail_model.dart';
import 'pick_pack_item_model.dart';

/// Dummy data for the Pick & Pack transaction detail page.
/// Replace with a real API/repository call once the backend is wired up.
class PickPackTransactionDummyData {
  static const PickPackDetailModel header = PickPackDetailModel(
    pickList: 'S25110400457',
    document: 'C25110400148',
    customerCode: 'PO2000006',
    customerName: 'POWERCOMP DISTRIBUTION SDN BHD SELANGOR',
    pickListCreatedBy: 'AQILAH',
    shipVia: 'VAN',
    warehouse: 'MAIN',
    remark: '',
  );

  static const List<PickPackItemModel> items = [
    PickPackItemModel(
      item: 1,
      partNumber: '7FM03760000',
      description: 'Toshiba Spare Part/Top Cover Assy B-EV4T',
      bin: 'A1-01-1A',
      balAfterPick: 0,
      toPick: 3,
      picked: 3,
      checked: 3,
      sn: 'N',
      reprint: 'N',
      pickedPackedOn: '30/10/2025 12:00PM',
      pickedPackedBy: 'JONAS',
      checkedOn: '30/10/2025 12:00PM',
      checkedBy: 'ALI',
    ),
  ];
}
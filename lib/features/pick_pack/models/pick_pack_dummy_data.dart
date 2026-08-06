import 'pick_pack_model.dart';

/// Dummy Pick & Pack records for UI development.
/// Replace with a real API/repository call once the backend is wired up.
class PickPackDummyData {
  static const List<PickPackModel> records = [
    PickPackModel(
      pickList: 'S25110400457',
      document: 'C25110400148',
      status: 'Picked',
      customerCode: 'PO2000006',
      customerName: 'POWERCOMP DISTRIBUTION SDN BHD SELANGOR',
      shipVia: 'VAN',
      warehouse: 'LAND',
      remark: '',
      deliveryDate: '5/11/2025',
    ),
    PickPackModel(
      pickList: 'S25110400458',
      document: 'C25110400149',
      status: 'Pending',
      customerCode: 'PO2000007',
      customerName: 'TECHWORLD SOLUTIONS SDN BHD',
      shipVia: 'LORRY',
      warehouse: 'SEA',
      remark: 'Fragile items',
      deliveryDate: '5/12/2025',
    ),
    PickPackModel(
      pickList: 'S25110400459',
      document: 'C25110400150',
      status: 'Cancelled',
      customerCode: 'PO2000008',
      customerName: 'MEGA RETAIL GROUP SDN BHD',
      shipVia: 'AIR',
      warehouse: 'AIR',
      remark: '',
      deliveryDate: '5/13/2025',
    ),
  ];
}
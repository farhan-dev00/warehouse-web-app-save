import 'good_receive_model.dart';

/// Dummy Good Receive records for UI development.
/// Replace with a real API/repository call once the backend is wired up.
class GoodReceiveDummyData {
  static const List<GoodReceiveModel> records = [
    GoodReceiveModel(
      receivingNo: 'RV2510300001',
      poNo: 'V25102200001',
      status: 'Completed',
      vendorCode: 'A46',
      vendorName: 'AMBLE ACTION SDN. BHD.',
      shipVia: 'LAND',
      waybill: 'A5101973',
      shpRef: 'V25102200001',
      category: 'Internal Use',
      orderType: 'EDP Exp',
    ),
    GoodReceiveModel(
      receivingNo: 'RV2510300002',
      poNo: 'V25102200002',
      status: 'Pending',
      vendorCode: 'A52',
      vendorName: 'GLOBAL SUPPLIES SDN. BHD.',
      shipVia: 'AIR',
      waybill: 'A5101974',
      shpRef: 'V25102200002',
      category: 'External Use',
      orderType: 'EDP Imp',
    ),
    GoodReceiveModel(
      receivingNo: 'RV2510300003',
      poNo: 'V25102200003',
      status: 'Cancelled',
      vendorCode: 'A61',
      vendorName: 'PRIMA HARDWARE ENTERPRISE',
      shipVia: 'SEA',
      waybill: 'A5101975',
      shpRef: 'V25102200003',
      category: 'Internal Use',
      orderType: 'EDP Exp',
    ),
  ];
}
 

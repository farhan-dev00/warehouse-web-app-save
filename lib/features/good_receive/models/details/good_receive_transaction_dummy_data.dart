import 'good_receive_detail_model.dart';
import 'good_receive_item_model.dart';

/// Dummy data for the Good Receive transaction detail page.
/// Replace with a real API/repository call once the backend is wired up.
class GoodReceiveTransactionDummyData {
  static const GoodReceiveDetailModel header = GoodReceiveDetailModel(
    receivingNo: 'RV2510300001',
    poNo: 'V25102200001',
    vendorCode: 'A46',
    vendorName: 'AMBLE ACTION SDN. BHD.',
    shpRef: 'V25102200001',
    shipVia: 'LAND',
    waybill: 'A5101973',
    noOfBoxes: 1,
    poCreatedBy: 'AQILAH',
    rcvDate: '30/10/2025',
    etaDate: '29/10/2025',
    categoryType: 'INTERNAL USE',
    orderType: 'EDP EXP',
  );

  static const List<GoodReceiveItemModel> items = [
    GoodReceiveItemModel(
      item: 1,
      partNumber: 'IT-HW',
      vendorPartNumber: 'HDTB540AK3CA',
      description:
          'Toshiba Canvio Basic (A5) USB 3.0 - 4TB – Black\nOUR PART NO: IT-HW',
      rcvPrice: 489.000000,
      rcvPriceF: 489.000000,
      poPrice: 489.000000,
      poPriceF: 489.000000,
      qtyRcv: 4,
      um: 'EA',
      totalItemCost: 1956.000000,
      tax: 0.00,
      totalCost: 1956.000000,
      receivedOn: '30/10/2025 12:00PM',
      receivedBy: 'JONAS',
    ),
  ];

  static const int noOfItemRcv = 1;
  static const int totalQtyRcv = 4;
}
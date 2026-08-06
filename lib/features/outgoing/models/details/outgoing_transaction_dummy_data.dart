import 'outgoing_detail_model.dart';
import 'outgoing_item_model.dart';
import 'outgoing_party_model.dart';

/// Dummy data for the Outgoing (Delivery Order) detail page.
/// Replace with a real API/repository call once the backend is wired up.
class OutgoingTransactionDummyData {
  static const OutgoingDetailModel header = OutgoingDetailModel(
    date: '4/11/2025',
    orderNo: 'C25110400244',
    doNo: 'S25110400414',
    invoiceNo: 'RR2511000053',
    purchaseOrder: 'RC25100084',
    salesPerson: 'C337 Elaine Chow Chooi Mee',
    accountNo: 'RE00316B001',
    oldAccountNo: 'VAN',
    shipVia: 'Van',
    terms: '7 Days',
    shipDate: '10/11/2025',
    billTo: OutgoingPartyModel(
      name: 'Rental Sales Account (TTMS Rental AC)',
      addressLines: [
        'Toshiba Tec Malaysia Sdn Bhd',
        'No. 5, Jalan Jurubina U1/18, Seksyen U1',
        'Hicom Glenmarie Industrial Park',
        '40150 Shah Alam',
        'Selangor',
      ],
      attn: '',
      tel: '60355687788',
    ),
    deliverTo: OutgoingPartyModel(
      name: 'Bermaz Motor Trading Sdn Bhd (PDI Northport)',
      addressLines: [
        'Lot 32, Lebuh Sultan Mohamed 1',
        'Kawasan Perindustrian Bandar Sultan Suleiman',
        '42000 Pelabuhan Klang',
        'Selangor',
      ],
      attn: 'En Azhar',
      tel: '60192678402',
    ),
  );

  static const List<OutgoingItemModel> items = [
    OutgoingItemModel(
      item: 1,
      quantityOrdered: 1,
      quantityDelivered: 1,
      quantityBackOrder: 0,
      partNo: 'E2528A',
      serialNo: 'CTBQ10771',
      description: 'ESTUDIO 2528A',
      checkedOn: '30/10/2025 12:00PM',
      checkedBy: 'ALI',
    ),
    OutgoingItemModel(
      item: 2,
      quantityOrdered: 1,
      quantityDelivered: 1,
      quantityBackOrder: 0,
      partNo: 'MR3033',
      serialNo: 'MGFQ83358',
      description: 'RADF (E3525AC/5525AC)',
      checkedOn: '30/10/2025 12:00PM',
      checkedBy: 'ALI',
    ),
    OutgoingItemModel(
      item: 3,
      quantityOrdered: 1,
      quantityDelivered: 1,
      quantityBackOrder: 0,
      partNo: 'MH5000',
      serialNo: '',
      description: 'DESK (E2508A/2000AC/3508A/3505AC)',
      checkedOn: '30/10/2025 12:00PM',
      checkedBy: 'ALI',
    ),
    OutgoingItemModel(
      item: 4,
      quantityOrdered: 1,
      quantityDelivered: 1,
      quantityBackOrder: 0,
      partNo: 'GD1370',
      serialNo: '9T560186',
      description: 'FAX BOARD (E2508A/2000AC/8508A/7506AC)',
      checkedOn: '30/10/2025 12:00PM',
      checkedBy: 'ALI',
    ),
  ];
}
import 'outgoing_model.dart';

/// Dummy Outgoing (Delivery Order) records for UI development.
/// Replace with a real API/repository call once the backend is wired up.
class OutgoingDummyData {
  static const List<OutgoingModel> records = [
    OutgoingModel(
      deliveryOrderNo: 'S25110400414',
      orderNo: 'C25110400244',
      invoiceNo: 'RR2511000053',
      status: 'Completed',
      deliveryOrderDate: '4/11/2025',
      billTo: 'Rental Sales Account\n(TTMS Rental AC)',
      deliverTo: 'Bermaz Motor Trading Sdn Bhd\n(PDI Northport)',
      purchaseOrder: 'RC25100084',
      terms: '7 Days',
    ),
    OutgoingModel(
      deliveryOrderNo: 'S25110400415',
      orderNo: 'C25110400245',
      invoiceNo: 'RR2511000054',
      status: 'Pending',
      deliveryOrderDate: '5/11/2025',
      billTo: 'Corporate Sales Account\n(TTMS Corp AC)',
      deliverTo: 'Sime Darby Motors Sdn Bhd\n(Glenmarie)',
      purchaseOrder: 'RC25100085',
      terms: '14 Days',
    ),
    OutgoingModel(
      deliveryOrderNo: 'S25110400416',
      orderNo: 'C25110400246',
      invoiceNo: 'RR2511000055',
      status: 'Cancelled',
      deliveryOrderDate: '6/11/2025',
      billTo: 'Government Sales Account\n(TTMS Gov AC)',
      deliverTo: 'UMW Toyota Motor Sdn Bhd\n(Shah Alam)',
      purchaseOrder: 'RC25100086',
      terms: '30 Days',
    ),
  ];
}
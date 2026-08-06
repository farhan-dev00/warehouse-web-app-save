import 'transfer_putaway_model.dart';

/// Dummy Transfer & Putaway records for UI development.
/// Replace with a real API/repository call once the backend is wired up.
class TransferPutawayDummyData {
  static const List<TransferPutawayModel> records = [
    TransferPutawayModel(partNo: 'E2528A', location: 'MAIN'),
    TransferPutawayModel(partNo: 'MR3033', location: 'MAIN'),
    TransferPutawayModel(partNo: 'MH5000', location: ''),
    TransferPutawayModel(partNo: 'GD1370', location: 'MAIN'),
  ];
}
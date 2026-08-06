/// Represents a single row in the Transfer & Putaway listing table.
class TransferPutawayModel {
  final String partNo;
  final String location;

  const TransferPutawayModel({
    required this.partNo,
    required this.location,
  });
}
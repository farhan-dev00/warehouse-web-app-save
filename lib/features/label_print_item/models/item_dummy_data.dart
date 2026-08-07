import 'item_model.dart';

/// Dummy Item records for UI development.
/// Replace with a real API/repository call once the backend is wired up.
class ItemDummyData {
  static const List<ItemModel> records = [
    ItemModel(partNo: 'E2528A', description: 'ESTUDIO 2528A'),
    ItemModel(partNo: 'MR3033', description: 'RADF (E3525AC/5525AC)'),
    ItemModel(
      partNo: 'MH5000',
      description: 'DESK (E2508A/2000AC/3508A/3505AC)',
    ),
    ItemModel(
      partNo: 'GD1370',
      description: 'FAX BOARD (E2508A/2000AC/8508A/7506AC)',
    ),
  ];
}
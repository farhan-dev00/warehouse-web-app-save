import 'location_model.dart';

/// Dummy Location records for UI development.
/// Replace with a real API/repository call once the backend is wired up.
class LocationDummyData {
  static const List<LocationModel> records = [
    LocationModel(location: 'MAIN', description: 'HQ Main'),
    LocationModel(location: 'A-01-01', description: 'Aisle A Rack 01 Row 01'),
    LocationModel(location: 'A-01-02', description: 'Aisle A Rack 01 Row 02'),
    LocationModel(location: 'A-02-03', description: 'Aisle A Rack 02 Row 03'),
  ];
}
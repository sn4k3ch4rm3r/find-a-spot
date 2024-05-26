import 'package:find_a_spot/features/create/models/location.dart';
import 'package:find_a_spot/features/create/services/location_service.dart';
import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  Location? _location;
  List<Location> _serachResult = [];

  LocationService service = LocationService();

  Location? get location => _location;
  set location(Location? value) {
    _location = value;
    notifyListeners();
  }

  List<Location> get searchResult => _serachResult;
  set searchResult(List<Location> value) {
    _serachResult = value;
    notifyListeners();
  }

  Future<void> search(String query) async {
    searchResult = await service.search(query);
  }
}

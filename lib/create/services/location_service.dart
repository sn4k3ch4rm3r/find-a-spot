import 'package:find_a_spot/create/models/location.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  Future<List<Location>> search(String query) async {
    return [
      Location(coordinates: const LatLng(47.462898, 19.061127), name: "Kopaszi gát"),
      Location(coordinates: const LatLng(47.486676, 19.048836), name: "Gellért-hegy")
    ];
  }
}

import 'package:find_a_spot/features/create/models/location.dart';
import 'package:find_a_spot/shared/data/nominatim/nominatim.dart';
import 'package:latlong2/latlong.dart';

class LocationRepository {
  final NominatimService _api = NominatimService();
  Future<List<Location>> search(String query) async {
    List<Place> results = await _api.search(query);
    return results.map((result) {
      return Location(
        coordinates: LatLng(result.lat, result.lon),
        name: result.name,
        address: result.displayName,
        osmId: result.osmId,
      );
    }).toList();
  }
}

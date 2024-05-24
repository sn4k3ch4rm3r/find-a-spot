import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class NominatimService {
  final String _baseUrl = 'nominatim.openstreetmap.org';

  Future<http.Response> _get(String endpoint, Map<String, String> parameters) async {
    parameters["format"] = "jsonv2";
    final uri = Uri.https(_baseUrl, endpoint, parameters);
    return await http.get(uri);
  }

  Future<List<Place>> search(String query) async {
    final response = await _get('/search', {
      'q': query
    });

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Place.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<Place> reverseSearch(double lat, double lon) async {
    final response = await _get('/reverse', {
      'lat': lat.toString(),
      'lon': lon.toString()
    });

    if (response.statusCode == 200) {
      return Place.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load place');
    }
  }
}

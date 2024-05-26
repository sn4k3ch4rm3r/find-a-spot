import 'package:latlong2/latlong.dart';

class Location {
  final LatLng coordinates;
  final String name;
  final String address;
  final int? osmId;

  Location({required this.coordinates, this.name = "", required this.address, this.osmId});
}

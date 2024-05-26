import 'package:latlong2/latlong.dart';

class CollectionModel {
  LatLng coordinates;
  String name;
  String address;
  String caption;
  String imageUrl;

  CollectionModel({required this.name, required this.caption, required this.imageUrl, required this.coordinates, required this.address});
}

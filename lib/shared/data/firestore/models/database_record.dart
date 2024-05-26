import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'database_record.g.dart';

@JsonSerializable()
class DatabaseRecord {
  String userId;
  int? osmId;
  @LatLngConverter()
  LatLng coordinates;
  String imageUrl;
  String caption;

  DatabaseRecord({required this.userId, required this.coordinates, required this.imageUrl, this.osmId, this.caption = ""});

  Map<String, dynamic> toJson() => _$DatabaseRecordToJson(this);
  factory DatabaseRecord.fromJson(Map<String, dynamic> obj) => _$DatabaseRecordFromJson(obj);
}

class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json['latitude'] as double, json['longitude'] as double);
  }

  @override
  Map<String, dynamic> toJson(LatLng latlng) {
    return {
      'latitude': latlng.latitude,
      'longitude': latlng.longitude,
    };
  }
}

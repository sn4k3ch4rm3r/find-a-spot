import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  @JsonKey(name: 'place_id')
  final int placeId;
  final String licence;
  @JsonKey(name: 'osm_type')
  final String osmType;
  @JsonKey(name: 'osm_id')
  final int osmId;
  @JsonKey(fromJson: double.parse)
  final double lat;
  @JsonKey(fromJson: double.parse)
  final double lon;
  final String category;
  final String type;
  @JsonKey(name: 'place_rank')
  final int placeRank;
  final double importance;
  @JsonKey(name: 'addresstype')
  final String addressType;
  final String name;
  @JsonKey(name: 'display_name')
  final String displayName;
  final Address? address;

  Place({required this.placeId, required this.licence, required this.osmType, required this.osmId, required this.lat, required this.lon, required this.category, required this.type, required this.placeRank, required this.importance, required this.addressType, required this.name, required this.displayName, this.address});

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
  factory Place.fromJson(Map<String, dynamic> obj) => _$PlaceFromJson(obj);
}

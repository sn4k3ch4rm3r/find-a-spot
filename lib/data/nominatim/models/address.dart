import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String? road;
  final String? suburb;
  final String? borough;
  final String? city;
  final String? region;
  final String? postcode;
  final String? country;
  @JsonKey(name: 'country_code')
  final String? countryCode;

  Address({this.road, this.suburb, this.borough, this.city, this.region, this.postcode, this.country, this.countryCode});

  Map<String, dynamic> toJson() => _$AddressToJson(this);
  factory Address.fromJson(Map<String, dynamic> obj) => _$AddressFromJson(obj);
}

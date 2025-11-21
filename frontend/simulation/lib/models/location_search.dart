class LocationSearchModel {
  final String displayName;
  final double lat;
  final double lon;

  LocationSearchModel({required this.displayName, required this.lat, required this.lon});

  factory LocationSearchModel.fromJson(Map<String, dynamic> json) {
    return LocationSearchModel(displayName: json['display_name'] as String, lat: double.parse(json['lat'] as String), lon: double.parse(json['lon'] as String));
  }
}

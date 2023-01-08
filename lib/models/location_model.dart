import 'dart:convert';

class MyLocation {
  final double latitude;
  final double longitude;

  MyLocation({
    required this.latitude,
    required this.longitude,
  });

  MyLocation copyWith({
    double? latitude,
    double? longitude,
  }) {
    return MyLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory MyLocation.fromMap(Map<String, dynamic> map) {
    return MyLocation(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyLocation.fromJson(String source) =>
      MyLocation.fromMap(json.decode(source));

  @override
  String toString() => 'MyLocation(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MyLocation &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

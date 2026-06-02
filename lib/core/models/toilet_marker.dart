class ToiletMarker {
  final String id;
  final String name;
  final String? address;
  final double latitude;
  final double longitude;
  final int safetyRating;
  final String? comment;

  const ToiletMarker({
    required this.id,
    required this.name,
    this.address,
    required this.latitude,
    required this.longitude,
    this.safetyRating = 3,
    this.comment,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'safetyRating': safetyRating,
    'comment': comment,
  };

  factory ToiletMarker.fromJson(Map<String, dynamic> json) => ToiletMarker(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] as String?,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    safetyRating: json['safetyRating'] as int? ?? 3,
    comment: json['comment'] as String?,
  );
}

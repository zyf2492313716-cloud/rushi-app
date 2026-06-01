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
}

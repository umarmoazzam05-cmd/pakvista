class TouristSpot {
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  bool isFavorite;

  TouristSpot({
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });
}

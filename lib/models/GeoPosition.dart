class GeoPosition {
  String city;
  String country;
  String region;
  double lat;
  double lon;

  GeoPosition(
      {required this.city,
      required this.country,
      required this.region,
      required this.lat,
      required this.lon});

  String areaTitle() => "$country , $region";
}

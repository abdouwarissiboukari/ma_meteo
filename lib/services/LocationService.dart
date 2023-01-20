import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:ma_meteo/models/GeoPosition.dart';
// import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geocode/geocode.dart';
import 'package:ma_meteo/services/ApiKeyServices.dart';

class LocationService {
  //Get Position
  Future<LocationData?> getPosition() async {
    try {
      Location location = Location();
      return location.getLocation();
    } on PlatformException catch (error) {
      print(
          "Nous avons une erreur pour récupérer la position : \n ${error.message}");
      return null;
    }
  }

  //Convertir position en ville

  // Future<GeoPosition?> getCity() async {
  //   final position = await getPosition();
  //   if (position == null) return null;
  //   final lat = position.latitude ?? 0.0;
  //   final lon = position.longitude ?? 0.0;
  //   List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat, lon);
  //   // print(placemarks);
  //   final firstChoice = placemarks.first;
  //   final GeoPosition geoPosition = GeoPosition(
  //     city: firstChoice.locality ?? "",
  //     lat: lat,
  //     lon: lon,
  //   );
  //   return geoPosition;
  // }

  Future<GeoPosition?> getCity() async {
    GeoCode geoCode = GeoCode(apiKey: geoCodeAPIKey);

    final position = await getPosition();
    if (position == null) return null;

    final lat = position.latitude ?? 0.0;
    final lon = position.longitude ?? 0.0;

    final Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lon);

    final GeoPosition geoPosition = GeoPosition(
      city: address.city ?? "",
      lat: lat,
      lon: lon,
    );
    return geoPosition;
  }

  //Convertir ville en position
  // Future<GeoPosition?> getCoordsFromCity(String city) async {
  //   final placemarks = await geocoding.locationFromAddress(city);
  //   if (placemarks.isEmpty) return null;
  //   final bestChoice = placemarks.first;
  //   return GeoPosition(
  //       city: city, lat: bestChoice.latitude, lon: bestChoice.longitude);
  // }
  Future<GeoPosition?> getCoordsFromCity(String city) async {
    GeoCode geoCode = GeoCode(apiKey: geoCodeAPIKey);
    final Coordinates coordinates =
        await geoCode.forwardGeocoding(address: city);
    if (coordinates == null) return null;

    final Address address = await geoCode.reverseGeocoding(
        latitude: coordinates.latitude!.toDouble(),
        longitude: coordinates.longitude!.toDouble());

    return GeoPosition(
        city: city,
        lat: coordinates.latitude!.toDouble(),
        lon: coordinates.longitude!.toDouble());
  }
}

import 'dart:convert';

import 'package:http/http.dart';
import 'package:ma_meteo/models/APIResponse.dart';
import 'package:ma_meteo/models/GeoPosition.dart';
import 'package:ma_meteo/services/ApiKeyServices.dart';

class ApiService {
  String baseUrl = "https://api.openweathermap.org/data/2.5/forecast";
  String lat = "lat=";
  String lon = "lon=";
  String appid = "appid=";
  String lang = "lang=fr";
  String units = "units=metric";

  String prepareQuery(GeoPosition geoPosition) {
    final geoLat = geoPosition.lat;
    final geoLon = geoPosition.lon;

    return "$baseUrl?$lat$geoLat&$lon$geoLon&$lang&$units&$appid$API";
  }

  Future<APIResponse> callApi(GeoPosition position) async {
    final queryString = prepareQuery(position);
    final uri = Uri.parse(queryString);
    final call = await get(uri);

    Map<String, dynamic> map = json.decode(call.body);
    return APIResponse.fromJson(map);
  }
}

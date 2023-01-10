import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ma_meteo/models/APIResponse.dart';
import 'package:ma_meteo/models/GeoPosition.dart';
import 'package:ma_meteo/services/ApiService.dart';
import 'package:ma_meteo/services/LocationService.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  GeoPosition? userPosition;
  APIResponse? apiResponse;

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userPosition?.city ?? "Ma météo"),
      ),
      body: Center(
        child: Text("Notre reponse : ${apiResponse?.cnt ?? 0}"),
      ),
    );
  }

  getUserLocation() async {
    final loc = await LocationService().getCity();
    if (loc != null) {
      setState(() {
        userPosition = loc;
      });
      apiResponse = await ApiService().callApi(userPosition!);
      setState(() {});
    }
  }
}

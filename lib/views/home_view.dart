import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ma_meteo/models/APIResponse.dart';
import 'package:ma_meteo/models/GeoPosition.dart';
import 'package:ma_meteo/services/ApiService.dart';
import 'package:ma_meteo/services/DataServices.dart';
import 'package:ma_meteo/services/LocationService.dart';
import 'package:ma_meteo/views/AddCityView.dart';
import 'package:ma_meteo/views/ForecastView.dart';
import 'package:ma_meteo/views/MyDrawer.dart';
import 'package:ma_meteo/views/NoDataView.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  GeoPosition? userPosition;
  GeoPosition? positionToCall;
  List<String> cities = [];
  APIResponse? apiResponse;

  @override
  void initState() {
    getUserLocation();
    updateCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(positionToCall?.city ?? "Ma météo"),
      ),
      drawer: MyDrawer(
        myPosition: userPosition,
        cities: cities,
        onTap: onTap,
        onDetele: removeCity,
      ),
      body: Column(
        children: [
          AddCityView(onAddCity: onAddCity),
          Expanded(
              child: (apiResponse == null)
                  ? NoDataView()
                  : ForecastView(response: apiResponse!))
        ],
      ),
    );
  }

// Obtenir position via le GPS
  getUserLocation() async {
    final loc = await LocationService().getCity();
    if (loc != null) {
      setState(() {
        userPosition = loc;
        positionToCall = loc;
      });
      callApi();
    }
  }

  // CallApi
  callApi() async {
    if (positionToCall == null) return;

    apiResponse = await ApiService().callApi(positionToCall!);
    setState(() {});
  }

// Nouvelle ville
  onTap(String string) async {
    Navigator.of(context).pop();
    removeKeyboard();
    if (string == userPosition?.city) {
      positionToCall = userPosition;
      callApi();
    } else {
      positionToCall = await LocationService().getCoordsFromCity(string);
      callApi();
    }
  }

  removeKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

// Ajouter une nouvelle ville
  onAddCity(String string) async {
    if (string.isNotEmpty) {
      DataServices().addCity(string).then((onSuccess) => updateCities());
      removeKeyboard();
    }
  }

  // Supprimer une ville
  removeCity(String string) async {
    DataServices().removeCity(string).then((onSuccess) => updateCities());
  }

  //Mettre a jour les ville
  updateCities() async {
    cities = await DataServices().getCities();
    setState(() {});
  }
}

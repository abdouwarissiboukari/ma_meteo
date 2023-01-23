import 'package:flutter/material.dart';
import 'package:ma_meteo/models/GeoPosition.dart';
import 'package:ma_meteo/views/HomeView.dart';

class AreaTitleView extends StatelessWidget {
  final GeoPosition? geoPosition = positionToCall;
  @override
  Widget build(BuildContext context) {
    return Text(
      geoPosition!.areaTitle(),
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.bold),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ma_meteo/models/APIResponse.dart';
import 'package:ma_meteo/models/GroupedWeather.dart';
import 'package:ma_meteo/services/DataConverter.dart';
import 'package:ma_meteo/views/DailyTileView.dart';
import 'package:ma_meteo/views/currentWeather.dart';

class ForecastView extends StatelessWidget {
  final APIResponse response;

  ForecastView({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    List<GroupedWeather> byDay = DataConverter().byDay(response);
    return Column(
      children: [
        CurrentWeather(forecast: response.list.first),
        Expanded(
            child: ListView.builder(
                itemBuilder: ((context, index) =>
                    DailyTileView(day: byDay[index])),
                itemCount: byDay.length))
      ],
    );
  }
}

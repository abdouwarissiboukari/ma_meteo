import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_meteo/models/GroupedWeather.dart';
import 'package:ma_meteo/services/DataConverter.dart';

class DailyTileView extends StatelessWidget {
  GroupedWeather day;

  DailyTileView({super.key, required this.day});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Image.network(
        DataConverter().fromIcon(day.icon),
      ),
      leading: Text(day.day),
      title: Text(day.description),
      subtitle: Text(day.minAndMax()),
    );
  }
}

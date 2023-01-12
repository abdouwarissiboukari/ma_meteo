import 'package:flutter/cupertino.dart';
import 'package:ma_meteo/models/APIResponse.dart';
import 'package:ma_meteo/models/GroupedWeather.dart';

class DataConverter {
  List<Map<String, dynamic>> listMappable(List<dynamic> list) {
    return list.map((e) => e as Map<String, dynamic>).toList();
  }

  String fromIcon(String string) {
    return "https://openweathermap.org/img/wn/$string@2x.png";
  }

  List<GroupedWeather> byDay(APIResponse response) {
    List<GroupedWeather> dailay = [];
    response.list.forEach((forecast) {
      var date = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
      String day = dayFromInt(date.weekday);
      int hour = date.hour;
      int min = forecast.main.temp_min.toInt();
      int max = forecast.main.temp_max.toInt();
      String description = forecast.weather.first.description;
      String icon = forecast.weather.first.icon;

      final index = dailay.indexWhere((d) => d.day == day);

      if (index == -1) {
        //Si il n'existe pas
        dailay.add(GroupedWeather(min, max, description, icon, day));
      } else {
        //Si il existe
        if (dailay[index].min > min) dailay[index].min = min;
        if (dailay[index].max < max) dailay[index].max = max;
        if (hour == 12 || hour == 13 || hour == 14) {
          dailay[index].description = description;
          dailay[index].icon = icon;
        }
      }
    });

    return dailay;
  }

  String dayFromInt(int day) {
    switch (day) {
      case 1:
        return "Lundi";
      case 2:
        return "Mardi";
      case 3:
        return "Mercredi";
      case 4:
        return "Jeudi";
      case 5:
        return "Vendredi";
      case 6:
        return "Samedi";
      default:
        return "Dimanche";
    }
  }
}

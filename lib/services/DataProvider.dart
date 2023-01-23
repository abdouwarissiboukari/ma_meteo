import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ma_meteo/services/DataServices.dart';

class DataProvider with ChangeNotifier {
  DataProvider() {
    getCities();
  }

  List<String> cities = [];

  getCities() async {
    cities = await DataServices().getCities();
    notifyListeners();
  }

  addCity(String string) async {
    final result = await DataServices().addCity(string);
    getCities();
    notifyListeners();
  }

  removeCity(String string) async {
    final result = await DataServices().removeCity(string);
    getCities();
    notifyListeners();
  }
}

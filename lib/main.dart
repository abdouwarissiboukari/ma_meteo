import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma_meteo/views/home_view.dart';

void main() {
  //Assurer l'init
  WidgetsFlutterBinding.ensureInitialized();
  //Vouloir l'application uniquement en portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

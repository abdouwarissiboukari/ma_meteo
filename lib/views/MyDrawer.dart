import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ma_meteo/models/GeoPosition.dart';

class MyDrawer extends StatelessWidget {
  GeoPosition? myPosition;
  List<String> cities;
  Function(String) onTap;
  Function(String String) onDetele;

  MyDrawer(
      {super.key,
      required this.myPosition,
      required this.cities,
      required this.onTap,
      required this.onDetele});

  @override
  Widget build(BuildContext context) {
    final itemCount = cities.length;

    return Drawer(
        child: Column(
      children: [
        header(context, myPosition!.city),
        townTitle(),
        Expanded(
          child: ListView.separated(
              itemBuilder: ((context, index) {
                return tappable(cities[index], true);
              }),
              separatorBuilder: ((context, index) => const Divider()),
              itemCount: itemCount),
        )
      ],
    ));
  }

  DrawerHeader header(BuildContext context, String string) {
    return DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        // padding: const EdgeInsets.symmetric(vertical: 50),
        child: Expanded(
          flex: 1,
          child: Column(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 32,
                color: Colors.white,
              ),
              Text(string),
            ],
          ),
        ));
  }

  Widget townTitle() {
    return Container(
      child: Text(
        "Gérer les villes",
        style: GoogleFonts.signika(fontSize: 25),
      ),
    );
  }

  ListTile tappable(String string, bool canDelete) {
    return ListTile(
      title: Text(
        string,
      ),
      onTap: (() => onTap(string)),
      trailing: (canDelete)
          ? IconButton(
              onPressed: (() => onDetele(string)),
              icon: const Icon(Icons.delete),
            )
          : null,
    );
  }
}

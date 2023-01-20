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
        townTitle(context),
        const Divider(),
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
    final Size size = MediaQuery.of(context).size;
    return DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: Container(
          width: size.width,
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

  Widget townTitle(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: size.width,
      height: 40,
      alignment: Alignment.center,
      transform: Matrix4.translationValues(0, -8, 0),
      // color: Theme.of(context).primaryColorLight,
      child: Text(
        "Lieux favoris",
        style: GoogleFonts.signika(fontSize: 20),
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

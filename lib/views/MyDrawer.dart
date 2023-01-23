import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ma_meteo/models/GeoPosition.dart';
import 'package:ma_meteo/services/DataProvider.dart';
import 'package:ma_meteo/views/AreaTitleView.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  GeoPosition? myPosition;
  // List<String> cities;
  Function(String) onTap;
  Function() onTapCurrent;
  // Function(String String) onDetele;

  MyDrawer({
    super.key,
    required this.myPosition,
    // required this.cities,
    required this.onTap,
    // required this.onDetele,
    required this.onTapCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final cities = context.watch<DataProvider>().cities;
    final itemCount = cities.length;

    return Drawer(
      child: Column(
        children: [
          header(context, myPosition!.city),
          townTitle(context),
          Divider(
            color: Theme.of(context).primaryColorLight,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: ((context, index) {
                  return tappable(context, cities[index], true);
                }),
                separatorBuilder: ((context, index) => const Divider()),
                itemCount: itemCount),
          )
        ],
      ),
    );
  }

  DrawerHeader header(BuildContext context, String string) {
    final Size size = MediaQuery.of(context).size;
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Container(
        width: size.width,
        child: InkWell(
          onTap: onTapCurrent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 32,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                string,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              AreaTitleView(),
            ],
          ),
        ),
      ),
    );
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

  ListTile tappable(BuildContext context, String string, bool canDelete) {
    return ListTile(
      title: Text(
        string,
      ),
      onTap: (() => onTap(string)),
      trailing: (canDelete)
          ? IconButton(
              onPressed: (() =>
                  context.read<DataProvider>().removeCity(string)),
              icon: const Icon(Icons.delete),
            )
          : null,
    );
  }
}

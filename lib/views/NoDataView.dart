import 'package:flutter/cupertino.dart';

class NoDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Aucune donnée pour le lieu sélectionné"),
    );
  }
}

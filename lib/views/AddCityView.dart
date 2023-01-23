import 'package:flutter/material.dart';
import 'package:ma_meteo/services/DataProvider.dart';
import 'package:provider/provider.dart';

class AddCityView extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  // Function(String string) onAddCity;

  // AddCityView({super.key, required this.onAddCity});
  AddCityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Ajouter une ville", border: InputBorder.none),
            ),
          ),
          IconButton(
            onPressed: (() {
              context.read<DataProvider>().addCity(controller.text);
              controller.text = "";
              FocusScope.of(context).requestFocus(FocusNode());
            }),
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddCityView extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  Function(String string) onAddCity;

  AddCityView({super.key, required this.onAddCity});

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
            onPressed: (() => onAddCity(controller.text)),
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

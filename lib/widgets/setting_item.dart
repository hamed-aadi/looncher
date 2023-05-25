import 'package:flutter/material.dart';


class SettingItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final String description;
  // add checkbox

  final TextStyle headerText = const TextStyle(fontSize: 20, color: Colors.white);
  final TextStyle descriptionText = const TextStyle(
    fontSize: 16, overflow: TextOverflow.visible, color: Colors.white70);

  const SettingItem(
    {super.key,
      required this.name,
      required this.onPressed,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          border: Border.all(color: Colors.white10, width: 1),
          borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(name, style: headerText),
                  Divider(),
                  Align(
                    child: Text(description, style: descriptionText),
                    alignment: Alignment.centerLeft),
            ])),
            const Icon(Icons.arrow_right)
          ],
    )));
  }
}

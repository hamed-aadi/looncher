import 'package:flutter/material.dart';

import 'settings_main_apps_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // minimum: EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text("Settings", style: TextStyle(fontSize: 32))),
            FavAppsChooser()
          ],
      )),
    );
  }
}

class FavAppsChooser extends StatefulWidget {
  const FavAppsChooser({super.key});
  @override
  State<FavAppsChooser> createState() => _FavAppsChooserState();
}

class _FavAppsChooserState extends State<FavAppsChooser> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SettingItem(
            name: "Main Apps",
            description: "apps that show on the home screen ",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsMainAppsPage()));
          }),
          SettingItem(
            name: "Other Thing",
            description: "a thing that changes another thing",
            onPressed: () {})
          ],
        ));
  }
}

class SettingItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final String description;
  // add checkbox

  final TextStyle headerText =
  const TextStyle(fontSize: 20, color: Colors.white);
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

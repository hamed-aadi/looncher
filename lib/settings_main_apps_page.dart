import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'main.dart';
import 'models/favorite_apps.dart';

class SettingsMainAppsPage extends StatelessWidget {
  const SettingsMainAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FavorateApps>(context, listen: false).update();
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text("Choose Favorate Apps",
                style: TextStyle(fontSize: 28))),
            const SizedBox(
              height: 650,
              child: FavAppsList(),
            )
            ],
          )),
    );
  }
}

class FavAppsList extends StatefulWidget {
  const FavAppsList({super.key});
  @override
  State<FavAppsList> createState() => _FavAppsListState();
}

class _FavAppsListState extends State<FavAppsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavorateApps>(builder: (context, favApps, _) {
      return Container(
        decoration: BoxDecoration(
              color: Colors.grey[850],
              border: Border.all(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favApps.apps.length,
              itemBuilder: (context, index) {
                bool appVal = favApps.apps.values.elementAt(index);
                return SwitchListTile(
                    title: Text(favApps.apps.keys.elementAt(index)),
                    value: appVal,
                    onChanged: (bool value) {
                      favApps.setapps(index, value);
                      setState(() {});
                    },
                    secondary: Image.memory(
                      favApps.icons[index]!,
                      fit: BoxFit.contain,
                      width: 35,
                    ));
              }));
    });
  }
}

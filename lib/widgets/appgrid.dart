import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:looncher/data/apps.dart';

class AppGrid extends StatelessWidget {
  const AppGrid({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<InstalledAppsModel>(context, listen: false).getApps();
    return Consumer<InstalledAppsModel>(
      builder: (context, installedApps, _) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 15,
          ),
          itemCount: installedApps.deviceApps.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Column(children: [
                 Image.memory(installedApps.deviceApps[index].icon!,
                   width: 40, height: 40,),
                 Text(installedApps.deviceApps[index].name),
              ]),
              onTap: () => openApp(installedApps.deviceApps[index].packageName),
              onLongPress: () =>
                openAppSettings(installedApps.deviceApps[index].packageName),
            );
          },
        );
      },
   );
  }
}

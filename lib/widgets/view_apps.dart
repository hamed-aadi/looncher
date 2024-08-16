import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:looncher/data/apps.dart';
import 'package:looncher/data/settings.dart';

class AppsSlice extends StatelessWidget {
  final Axis axis;

  const AppsSlice(this.axis, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, settings, _) {
        if (settings.mainApps.isEmpty) {
          return Container(
            width: (axis == Axis.horizontal) ? 100: 50,
            height: (axis == Axis.horizontal) ? 50: 100,
            color: Colors.red,
            child: Text("Empty")
          );
        } else {
          return Container(
            width: (axis == Axis.horizontal) ? 100: 50,
            height: (axis == Axis.horizontal) ? 50: 100,
            color: Colors.grey,
            child: ListView.builder(
              itemCount: settings.mainApps.length,
              scrollDirection: axis,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Image.memory(settings.mainApps[index].icon!,
                    width: 50, height: 50),
                  onTap: () => openApp(settings.mainApps[index].packageName),
                );
              },
          ));
        }
    });
  }
}

class AppsPage extends StatefulWidget {
  final MainAxisAlignment alignment;
  const AppsPage(this.alignment, {super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  @override
  Widget build(BuildContext context) {
    return
    SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
          title: const Text("All Applications"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.sort_by_alpha), // allbool ? :
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          color: Colors.grey,
          child: AlphabeticalAppGrid())
    ));
  }
}

class AlphabeticalAppGrid extends StatelessWidget {
  const AlphabeticalAppGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InstalledAppsModel>(
      builder: (context, installedApps, _) {
        return GridView.builder(
          // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //   maxCrossAxisExtent: 10,
          // ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4),
          itemCount: installedApps.deviceApps.length,
          itemBuilder: (context, index) {
            return AppWidget(installedApps.deviceApps[index]);
          },
        );
      },
    );
  }
}

class AppWidget extends StatelessWidget {
  final App app;
  const AppWidget(this.app, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      child: InkWell(
        child: Column(children: [
            Image.memory(app.icon!, width: 60, height: 60),
            Text(app.name),
        ]),
        onTap: () => openApp(app.packageName),
        onLongPress: () => showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.memory(app.icon!, width: 100, height: 100),
                  Text(app.name),
                  Divider(),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<SettingsProvider>(context,
                        listen: false)
                      .addApp(app);
                    },
                    child: Text("Add to Faviorate Applications")),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<SettingsProvider>(context,
                        listen: false)
                      .removeApp(app);
                    },
                    child: Text("Uninstall App")),
                  ElevatedButton(
                    onPressed: () {
                      openAppSettings(app.name);
                    },
                    child: Text("Open App info")),
                ], // scrollable list of all launch methods
              ),
            );
        }),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            width: (axis == Axis.horizontal) ? 200: 70,
            height: (axis == Axis.horizontal) ? 70: 200,
            color: Theme.of(context).cardColor,
            child: Center(child: Text("Empty"))
          );
        } else {
          return Container(
            width: (axis == Axis.horizontal) ? 200: 70,
            height: (axis == Axis.horizontal) ? 70: 200,
            color: Theme.of(context).cardColor,
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
      body: Consumer<InstalledAppsModel>(
        builder: (context, installedApps, __) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                pinned: true,
                title: SearchAnchor.bar(
                  viewBackgroundColor: Theme.of(context).canvasColor,
                  barTrailing: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.toc),
                    ),
                  ],
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
                    List<App> apps = Provider.of<InstalledAppsModel>(context, listen: false).deviceApps;
                    final keyword = controller.text;
                    final result = apps.where(
                      (element) => element.name.toLowerCase().contains(keyword.toLowerCase())).toList();
                    
                    return List<ListTile>.generate(
                      result.length,
                      (index) => ListTile(
                        minVerticalPadding: 15,
                        leading: Image.memory(result[index].icon!),
                        title: Text(result[index].name),
                        onTap: () => openApp(result[index].packageName),
                        onLongPress: () => openAppSettings(result[index].packageName),
                      )
                    );
                  },  
                )
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              MainAppsGrid(installedApps.deviceApps),
            ],
          );
        }
      )
    );
  }
}


// class SearchAppsGrid extends StatelessWidget {
  
// }


class MainAppsGrid extends StatelessWidget {
  final List<App> deviceApps;
  
  const MainAppsGrid(this.deviceApps, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return SliverAnimatedGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 0,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
        maxCrossAxisExtent: Provider.of<SettingsProvider>(context, listen: true).iconSize,
      ),
      initialItemCount: deviceApps.length,
      itemBuilder: (context, index, animation) {
        return AppWidget(
          deviceApps[index],
          Provider.of<SettingsProvider>(context, listen: true).iconSize * 0.5
        );
      },
    );
  }
}
class AppWidget extends StatelessWidget {
  final App app;
  final double size;
  const AppWidget(this.app, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.3,
      ),
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.memory(app.icon!),//, width: size, height: size),
            Text(
              app.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: 10
              ),
            ),
          ]
        ),
        
        onTap: () => openApp(app.packageName),
        
        onLongPress: () => showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.memory(
                    app.icon!,
                    width: 100, height: 100,
                    filterQuality: FilterQuality.high,
                  ),
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
                      openAppSettings(app.packageName);
                    },
                    child: Text("Open App info")),
                ], // scrollable list of all launch methods
              ),
            );
        }),
    ));
  }
}

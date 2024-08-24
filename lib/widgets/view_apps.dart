import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:looncher/widgets/view.dart';
import 'package:looncher/data/apps.dart';
import 'package:looncher/data/settings.dart';

class AppsSlice extends StatelessWidget {
  final Axis axis;

  const AppsSlice(this.axis, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, settings, _) {
        if (settings.mainApps.isEmpty) {
          return BaseSlice(
            axis, Center(child: Text("Add Apps From The Menu"))
          );
        } else {
          return BaseSlice(
            axis,
            Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              direction: axis,
              children: List<InkWell>.generate(
                settings.mainApps.length,
                (index) => InkWell(
                  child: Image.memory(settings.mainApps[index].icon!,
                    width: 55, height: 55),
                  onTap: () => openApp(settings.mainApps[index].packageName),
                )
              )
            )
          );
        }
    });
  }
}

class AppsPage extends StatelessWidget {
  final MainAxisAlignment alignment;
  final Axis reverseAxis;
  AppsPage(this.reverseAxis, this.alignment, {super.key});

  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      reverseAxis: reverseAxis,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  onTap: controller.openView,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.search)
                  ),
                  trailing: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.toc),
                    ),
                  ]
                );
              },
              searchController: controller,
              viewBackgroundColor: Theme.of(context).canvasColor,
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                List<App> apps =
                Provider.of<InstalledAppsModel>(context, listen: false).deviceApps;
                final keyword = controller.text;
                final result = apps.where(
                  (element) =>
                  element.name.toLowerCase().contains(keyword.toLowerCase())).toList();
                return List<ListTile>.generate(
                  result.length,
                  (index) => ListTile(
                    minVerticalPadding: 15,
                    leading: Image.memory(result[index].icon!),
                    title: Text(result[index].name),
                    onTap: () {
                      openApp(result[index].packageName);
                      controller.closeView("");
                    },
                    onLongPress: () {
                      openAppSettings(result[index].packageName);
                      controller.closeView("");
                    } 
                  )
                );
              },  
          )),
          Expanded(child: MainAppsGrid()),
        ],
      )
    );
  }
}

class MainAppsGrid extends StatelessWidget {
  
  const MainAppsGrid({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<App> installedApps = Provider.of<InstalledAppsModel>(context, listen: true).deviceApps;
    return Container(
      padding: EdgeInsets.all(10),
      child: AnimatedGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
          maxCrossAxisExtent: Provider.of<SettingsProvider>(context, listen: true).iconSize,
        ),
        initialItemCount: Provider.of<InstalledAppsModel>(context, listen: true).deviceApps.length,
        itemBuilder: (context, index, animation) {
          return AppWidget(
            installedApps[index],
            Provider.of<SettingsProvider>(context, listen: true).iconSize * 0.5
          );
        },
    ));
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

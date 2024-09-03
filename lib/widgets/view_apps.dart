import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:looncher/widgets/view.dart';
import 'package:looncher/data/apps.dart';
import 'package:looncher/data/settings.dart';

class AppsSlice extends StatelessWidget {
  final Axis axis;

  const AppsSlice(this.axis, {super.key});
  
  Widget proxyDecorator(
    Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          color: Colors.transparent,
          elevation: elevation,
          shadowColor: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "apps";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        if (settings.mainApps.isEmpty) {
          return BaseSlice(
            axis, Center(child: Text("Add Apps From The Menu"))
          );
        } else {
          return BaseSlice(
            axis,
            Center(
              child: ReorderableListView(
                shrinkWrap: true,
                scrollDirection: axis,
                onReorder: settings.setMainApps,
                proxyDecorator: proxyDecorator,
                children: List<Padding>.generate(
                  settings.mainApps.length,
                  (index) => Padding(
                    key: Key('$index'),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      child: Image.memory(
                        settings.mainApps[index].icon!,
                        width: 60, height: 60),
                      onTap: () => openApp(settings.mainApps[index].packageName),
                  ))
                )
            ))
          );
        }
    });
  }
}

class AppsPage extends StatelessWidget {
  final Axis reverseAxis;
  AppsPage(this.reverseAxis, {super.key});

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
    return Consumer<InstalledAppsModel>(
      builder: (context, installedApps, _) => Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9,
            maxCrossAxisExtent: Provider.of<SettingsProvider>(context, listen: true).iconSize,
          ),
          itemCount: installedApps.deviceApps.length,
          itemBuilder: (context, index) {
            return AppWidget(
              installedApps.deviceApps[index],
              Provider.of<SettingsProvider>(context, listen: true).iconSize * 0.5
            );
          },
    )));
  }
}


class AppWidget extends StatefulWidget {
  final App app;
  final double size;
  const AppWidget(this.app, this.size, {super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  final _focusNode = FocusNode(debugLabel: 'App widget Menu');
  final controller = MenuController();
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    bool fav = Provider.of<SettingsProvider>(context, listen: false)
    .mainApps.contains(widget.app);
    return MenuAnchor(
      controller: controller,
      style: MenuStyle(
        padding: WidgetStateProperty.resolveWith((_) => EdgeInsets.all(0)),
      ),
      childFocusNode: _focusNode,
      menuChildren: [
        ListTile(
          leading: Icon((fav == true) ? Icons.favorite : Icons.favorite_border),
          title: Text((fav == true) ? "remove from favorite" : "add to favorite"),
          onTap: () {
            if (fav == true) {
              Provider.of<SettingsProvider>(context, listen: false).removeApp(widget.app);
            } else {
              Provider.of<SettingsProvider>(context, listen: false).addApp(widget.app);
            }
            controller.close();
          },
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text("Open App Info"),
          onTap: () {
            openAppSettings(widget.app.packageName);
            controller.close();
          }
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text("Open in Store"),
          onTap: () {
            String uri = "https://play.google.com/store/apps/details?id=${widget.app.packageName}";
            launchUrl(Uri.parse(uri));
            controller.close();
          }
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text("Uninstall"),
          onTap: () {
            uninstallApp(widget.app.packageName);
            controller.close();
          }
        ),
      ],
      builder: (_, MenuController controller, __) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: widget.size * 0.3),
          child: GestureDetector(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.memory(widget.app.icon!),
                Text(
                  widget.app.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 10
                  ),
                ),
              ]
            ),
            onTap: () => openApp(widget.app.packageName),
            onLongPress: () => controller.open(),
        ));
      }
    );
  }
}


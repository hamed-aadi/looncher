import 'package:flutter/material.dart';

import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import 'main.dart';
import 'theme.dart';

class AppListPage extends StatefulWidget {
  final bool focusSearch;
  const AppListPage({required this.focusSearch, super.key});
  
  @override
  State<AppListPage> createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {

  List<AppInfo> filteredApps = [];
  
  @override
  initState() {
    // Apps.getApps();
    filteredApps = Apps.appsList;
    super.initState();
  }
  
  void _filter(String keyword) {
    List<AppInfo> result = [];
    if (keyword.isEmpty) {
      result = Apps.appsList;
    } else {
      result = Apps.appsList.where(
        (element) => element.name!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    setState(() {
        filteredApps = result;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: SafeArea(
          child: Column(
            children: [
            Container(
              // height: 40,
              // width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding:const EdgeInsets.all(0),
              decoration: neuRecEmboss,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy < 20) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder:
                        (context) => const Launcher()));
                  }
                },
                child: TextField(
                  autofocus: widget.focusSearch,
                  onChanged: (value) => _filter(value),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    border: InputBorder.none,
                    hintText: 'Search'),
              ))
            ),
            
          Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 500,
                child:RefreshIndicator(
                  onRefresh: () {
                    Apps.getApps();
                    filteredApps = Apps.appsList;                  
                    setState(() {});
                    return Future<void>.delayed(const Duration(seconds: 0));
                  },
                  child: AppsList(filteredApps)))),
          ],
  ))));
}
}

class AppsList extends StatelessWidget {
  final List<AppInfo> appInfoList;
  const AppsList(this.appInfoList, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 15,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: appInfoList.length,
        itemBuilder: (context, index) {
          AppInfo app = appInfoList[index];
          return InkWell(
            child: Column(
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.all(10),
                  child: Image.memory(
                    app.icon!,
                    fit: BoxFit.contain,
                )),
                SizedBox(
                  width: 90,
                  child:Text(
                    app.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                ))
            ]),
            onTap: () => InstalledApps.startApp(app.packageName!),
            onLongPress: () => InstalledApps.openSettings(app.packageName!),
          );
    }));
  }
}

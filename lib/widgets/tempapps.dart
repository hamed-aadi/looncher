import 'package:flutter/material.dart';

import 'package:looncher/data/apps.dart';

// DeviceApps deviceApps = DeviceApps();

class TempApps extends StatefulWidget {
  const TempApps({super.key});

  @override
  State<TempApps> createState() =>  _TempAppsState();
}

class _TempAppsState extends State<TempApps> {
  
  List<App> applist = [];

  update() async {
    final _applist = await deviceApps.getApps();
    setState(() {
        applist = _applist;
    });
  }
  
  @override
  void initState() {
    update();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            update();
            deviceApps.uninstallApp("org.videolan.vlc");
          },
          child: Text("update"),
        ),
        
        Container(
          height: 700,
          width: 400,
          child: ListView.builder(
            itemCount: applist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(applist[index].name),
                leading: Image.memory(
                  applist[index].icon!,
                  fit: BoxFit.contain,
                ),
                subtitle: Text("${applist[index].packageName} version: ${applist[index].version}"),
                onTap: () => deviceApps.openApp(applist[index].packageName),
                onLongPress: () => deviceApps.openAppSettings(applist[index].packageName),
              );
            },
          )
    )]);
  }
}

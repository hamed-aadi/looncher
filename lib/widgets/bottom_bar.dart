import 'package:flutter/material.dart';

import 'package:installed_apps/installed_apps.dart';

import '../main.dart';
import '../app_list_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < -10) {
          Navigator.of(context).push(
            MaterialPageRoute(builder:
              (context) => const AppListPage(focusSearch: false)));
        }
      },
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        // padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        color: Colors.transparent,
        //   border: Border.all(color: Colors.white10, width: 1),
        //   borderRadius: BorderRadius.circular(10)),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[
            SearchBox(),
            MessageIcon(),
            CallIcon(),
          ]
    )));
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AppListPage(focusSearch: true)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 30),
        decoration: neuRecEmboss,
        height: 40,
        width: 200,
        padding: const EdgeInsets.all(10),
        // color: Colors.green,
        child: const Align(alignment: Alignment.centerLeft, child: Text("Search"))));
  }
}

class MessageIcon extends StatelessWidget {
  const MessageIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: neuRec,
      // BoxDecoration(
      //   color: Colors.black,
      //   border: Border.all(color: Colors.white10, width: 2),
      //   shape: BoxShape.circle),
      child: InkWell(
        child: const Icon(Icons.messenger_outline),
        onTap: () {
          InstalledApps.startApp("com.google.android.apps.messaging");
        }
    ));
  }
}


class CallIcon extends StatelessWidget {
  const CallIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: neuRec,
      // BoxDecoration(
      //   color: Colors.black,
      //   border: Border.all(color: Colors.white10, width: 2),
      //   shape: BoxShape.circle),
      child: InkWell(
        child: const Icon(Icons.call_rounded),
        onTap: () {
          InstalledApps.startApp("com.android.contacts");
        }
    )); 
  }
}

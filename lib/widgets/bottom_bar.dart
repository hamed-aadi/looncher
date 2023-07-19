import 'package:flutter/material.dart';

import 'package:installed_apps/installed_apps.dart';

import '../theme.dart';
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
        margin: const EdgeInsets.only(bottom: 10),
        height: 60,
        width: double.infinity,
        // padding: EdgeInsets.all(10),
        color: Colors.transparent,
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


Route _createApplistRoute() {
  return PageRouteBuilder(
    pageBuilder:
    (context, animation, secondaryAnimation) => const AppListPage(focusSearch: true),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_createApplistRoute());
      },
        child: Container(
          margin: const EdgeInsets.only(right: 30),
        decoration: neuRecEmboss,
        height: 40,
        width: 200,
        padding: const EdgeInsets.all(10),
        // color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Search"),
            Icon(Icons.search)
          ]
  )));
}
}

class MessageIcon extends StatelessWidget {
  const MessageIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: convexButton,
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
      decoration: convexButton,
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

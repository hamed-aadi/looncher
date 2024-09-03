import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:looncher/data/settings.dart';
import 'package:looncher/widgets/settings_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: ListView(
          children: const [
            SettingItem(
              "Appearance", AppearanceSettings(),
              Icons.color_lens, "wallpaper and theme"),
            SettingItem(
              "clock", ClockSettings(),
              Icons.timer, "clock shape"),
            SettingItem(
              "Views", ClockSettings(),
              Icons.home, "placements of pages on the home screen "),
            SettingItem(
              "Apps", AppsSettings(),
              Icons.apps, "settings for apps drawer"),
          ],
        )
      )
    );
  }
}


class SettingItem extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData icon;
  final String subtitle;
  const SettingItem(
    this.title,
    this.child,
    this.icon,
    this.subtitle,
    {super.key}
  );
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SettingItemPage(title, child)
        )
      )
    );
  }
}


class SettingItemPage extends StatelessWidget {
  final Widget child;
  final String title;
  const SettingItemPage(
    this.title,
    this.child,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: child,
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(        //add gesture detector
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Provider.of<SettingsProvider>(
              context, listen: true).homeScreenWidgets,
          )
        )
      )
    );
  }
}
  


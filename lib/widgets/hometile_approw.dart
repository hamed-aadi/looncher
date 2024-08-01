import 'package:flutter/material.dart';
import 'package:looncher/data/settings.dart';

import 'package:provider/provider.dart';

class AppRowTile extends StatelessWidget {
  const AppRowTile({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Provider.of<SettingsProvider>(context).theme.appRowDecoration,
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 100,),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: 50,
                decoration:
                Provider.of<SettingsProvider>(context).theme.buttonDecoration,
                child: Icon(Icons.apps, color: Colors.white)),
          ))
        ],
      ),
    );
  }
}

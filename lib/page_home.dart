import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/settings.dart';
import 'package:looncher/widgets/hometile_approw.dart';
import 'package:looncher/widgets/hometile_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Provider.of<GlobalSettingsProvider>(context).background,
        body: Container(        //add gesture detector
          child: const  Column(
            children: [         //replace with list from settings
              TimeTile(),
            ],
          ) 
        )
      )
    );
  }
}

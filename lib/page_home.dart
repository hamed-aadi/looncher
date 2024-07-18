import 'package:flutter/material.dart';
import 'package:looncher/widgets/tempapps.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          child: TempApps(),
        )
      )
    );
  }
}

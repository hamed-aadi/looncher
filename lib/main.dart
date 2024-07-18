import 'package:flutter/material.dart';

import 'package:looncher/page_home.dart';

void main() {
  runApp(const Launcher());
}

class Launcher extends StatelessWidget {
  const Launcher({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopScope(
        canPop: false,
        child: const HomePage())
    );
  }
}

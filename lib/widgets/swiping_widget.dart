import 'package:flutter/material.dart';

import '../main.dart';

class SwipingWidget extends StatefulWidget {
  const SwipingWidget({super.key});
  @override
  SwipingWidgetState createState() => SwipingWidgetState();
}

class SwipingWidgetState extends State<SwipingWidget> {
  int swipedPos = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 50,
    );
  }
}

// Image.memory(Apps.appsList.where(
//     (element) => element.name!.toLowerCase().contains("mess")).toList()[0].icon!,
//   fit: BoxFit.contain,
// ),

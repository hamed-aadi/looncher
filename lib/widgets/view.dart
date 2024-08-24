import 'package:flutter/material.dart';

class BaseSlice extends StatelessWidget {
  final Axis axis;
  final Widget child;
  const BaseSlice(this.axis, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (axis == Axis.horizontal) ? 400: 85,
      height: (axis == Axis.horizontal) ? 85: 400,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      )
    );
  }
}

class BasePage extends StatelessWidget {
  final Axis reverseAxis;
  final Widget child;
  const BasePage({
      required this.reverseAxis,
      required this.child,
      super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: reverseAxis,
      slivers: [
        SliverFillRemaining(
          child: Scaffold(
            backgroundColor: Theme.of(context).canvasColor.withOpacity(0.3),
            body: child,
          ),
        )
      ]
    );
  }
}

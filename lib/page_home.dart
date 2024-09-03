import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import 'data/settings.dart';
import 'data/apps.dart';
import 'widgets/hometile_time.dart';
import 'page_settings.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final vPageViewController = PageController(initialPage: 1);
  final hPageViewController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        vPageViewController.jumpToPage(1);
        hPageViewController.jumpToPage(1);
      },
      child: SafeArea(
        child: Consumer<SettingsProvider>(
          builder: (context, settings, _) {
            return PageView(
              scrollDirection: Axis.vertical,
              controller: vPageViewController,
              children: [
                settings.upPage,
                PageView(
                  scrollDirection: Axis.horizontal,
                  controller: hPageViewController,
                  children: [
                    settings.leftPage,
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      body: CenterWidget(
                        settings,
                        vPageViewController,
                        hPageViewController,
                    )),
                    settings.rightPage,
                ]),
                settings.downPage,
            ]);
          }
        )
      )
    );
  }
}

class CenterWidget extends StatefulWidget {
  final SettingsProvider settings;
  final PageController vPageViewController;
  final PageController hPageViewController;

  const CenterWidget(
    this.settings,
    this.vPageViewController,
    this.hPageViewController,
    {super.key}
  );

  @override
  State<CenterWidget> createState() => _CenterWidgetState();
}

class _CenterWidgetState extends State<CenterWidget> {
  late ScrollController vController;
  late ScrollController hController;

  final duration = const Duration(milliseconds: 100);
  final curve = Curves.linear;

  void vCenter() =>
  vController.animateTo(vController.position.maxScrollExtent / 2,
    duration: duration, curve: curve);

  void hCenter() =>
  hController.animateTo(hController.position.maxScrollExtent / 2,
    duration: duration, curve: curve);

  void moveV(double dy) {
    if (dy > 10) {
      vController.animateTo(0, curve: curve, duration: duration);
      if (vController.position.pixels == 0) {
        widget.vPageViewController
        .animateToPage(0, curve: curve, duration: duration);
      }
    } else if (dy < -10) {
      vController.animateTo(vController.position.maxScrollExtent,
        curve: curve, duration: duration);
      if (vController.position.pixels == vController.position.maxScrollExtent) {
        widget.vPageViewController
        .animateToPage(2, curve: curve, duration: duration);
      }
    }
  }

  void moveH(double dx) {
    if (dx > 10) {
      hController.animateTo(0, curve: curve, duration: duration);
      if (hController.position.pixels == 0) {
        widget.hPageViewController
        .animateToPage(0, curve: curve, duration: duration);
      }
    } else if (dx < -10) {
      hController.animateTo(hController.position.maxScrollExtent,
        curve: curve, duration: duration);
      if (hController.position.pixels == hController.position.maxScrollExtent) {
        widget.hPageViewController
        .animateToPage(2, curve: curve, duration: duration);
      }
    }
  }

  @override
  void initState() {
    vController = ScrollController();
    hController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_){
        vController.jumpTo(vController.position.maxScrollExtent / 2);
        hController.jumpTo(hController.position.maxScrollExtent / 2);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: vController,
      physics: NeverScrollableScrollPhysics(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: hController,
        physics: NeverScrollableScrollPhysics(),
        child: Column(children: [
            widget.settings.upSlice,
            Row(children: [
                widget.settings.leftSlice,
                GestureDetector(
                  onVerticalDragEnd: (details) {
                    moveV(details.velocity.pixelsPerSecond.dy);
                  },
                  onHorizontalDragEnd: (details) {
                    moveH(details.velocity.pixelsPerSecond.dx);
                  },
                  onLongPress: () {
                    vCenter();
                    hCenter();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage()));
                  },
                  onTap: () {
                    vCenter();
                    hCenter();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(00),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top +
                      MediaQuery.of(context).padding.bottom),
                    child: Center(child: TimeTile()),
                  )
                ),
                widget.settings.rightSlice,
            ]),
            widget.settings.downSlice,
    ])));
  }
}

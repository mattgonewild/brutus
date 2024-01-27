import 'package:dash/view/widget/panel_chart.dart';
import 'package:dash/view/widget/panel_interactive_info.dart';
import 'package:dash/view/widget/panel_node.dart';
import 'package:dash/view/widget/rail_action.dart';
import 'package:flutter/material.dart';

class DashboardRoute extends StatelessWidget {
  const DashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => pickLayout(context, constraints));
  }
}

Widget pickLayout(BuildContext context, BoxConstraints constraints) {
  if (constraints.maxWidth < 1080 || constraints.maxHeight < 800) {
    // mobile
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return const DashboardMobilePortrait();
    } else {
      return const DashboardMobileLandscape();
    }
  } else {
    // desktop
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return const DashboardDesktopPortrait();
    } else {
      return const DashboardDesktopLandscape();
    }
  }
}

class DashboardMobilePortrait extends StatelessWidget {
  const DashboardMobilePortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.purple);
  }
}

class DashboardMobileLandscape extends StatelessWidget {
  const DashboardMobileLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

class DashboardDesktopPortrait extends StatelessWidget {
  const DashboardDesktopPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.orange);
  }
}

class DashboardDesktopLandscape extends StatelessWidget {
  const DashboardDesktopLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Expanded(flex: 1, child: ActionRail()),
      Expanded(flex: 10, child: Row(children: [
          Expanded(flex: 2, child: Column(children: [
            AspectRatio(aspectRatio: 1.1, child: ChartPanel()),
            Expanded(flex: 1, child: InteractiveInfoPanel()),
          ])),
          Expanded(flex: 7, child: NodePanel()),
    ]))]);
  }
}

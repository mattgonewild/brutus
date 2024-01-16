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
  if (constraints.maxWidth < 1080) {
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
    return Container(color: Colors.red);
  }
}

part of 'dashboard_route_amal.dart';

class DashboardRoute extends StatelessWidget {
  const DashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => pickLayout(context, constraints));
  }
}

Widget pickLayout(BuildContext context, BoxConstraints constraints) {
  WidgetsBinding.instance.addPostFrameCallback((_) => context.read<UIBloc>().add(LayoutConstraintsUpdated(constraints.maxWidth, constraints.maxHeight)));
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
    return BlocBuilder<UIBloc, UIState>(
        buildWhen: (previous, current) => previous.themeData.canvasColor != current.themeData.canvasColor,
        builder: (context, state) => Container(
              color: state.themeData.canvasColor,
              child: const Row(children: [
                Expanded(flex: 8, child: ActionRail()),
                Expanded(
                    flex: 100,
                    child: Row(children: [
                      Expanded(
                          flex: 2,
                          child: Column(children: [
                            AspectRatio(aspectRatio: 1.1, child: ChartPanel()),
                            Expanded(flex: 1, child: InteractiveInfoPanel()),
                          ])),
                      Expanded(flex: 7, child: NodePanel()),
                    ]))
              ]),
            ));
  }
}

import 'package:dash/view/widget/hello_world.dart';
import 'package:flutter/material.dart';

class DashboardRoute extends StatelessWidget {
  const DashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const CenteredHelloWorld();
  }
}

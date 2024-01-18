import 'package:dash/bloc/node/node_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: add sortable header
class NodeRail extends StatelessWidget {
  const NodeRail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeBloc, NodeState>(buildWhen: (previous, current) => previous != current,
      builder: (context, state) => ListView.builder(itemCount: state.nodeCount,
        itemBuilder: (context, index) => const AspectRatio(aspectRatio: 1.2, child: AnimatedSwitcher(duration: Duration(milliseconds: 200), child: NodeRailCard()))
      )
    );
  }
}

class NodeRailCard extends StatelessWidget {
  const NodeRailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

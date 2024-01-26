import 'package:brutus/brutus.dart';
import 'package:dash/bloc/node/node_bloc.dart';
import 'package:dash/view/widget/painter_percentage_bar.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: add sortable header
class NodeRail extends StatelessWidget {
  const NodeRail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeBloc, NodeState>(buildWhen: (previous, current) => previous != current,
      builder: (context, state) => ListView.builder(itemCount: state.nodes.length,
        itemBuilder: (context, index) => AspectRatio(aspectRatio: 1.2, child: AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: NodeRailCard(node: state.nodes.elementAt(index), last: state.last[state.nodes.elementAt(index).id] ?? Proc()))) // TODO: ...
      )
    );
  }
}

class NodeRailCard extends StatelessWidget {
  const NodeRailCard({super.key, required Worker node, required Proc last}) : _node = node, _last = last;

  final Worker _node;
  final Proc _last; // TODO: ...

  Widget _buildRow(String label, Widget value) => Row(children: [Text(label), value]);

  double _calculateCpuUsage(Int64 total, Int64 idle) => ((total - idle).toDouble() / total.toDouble()) * 100;

  double _calculateMemUsage(Int64 total, Int64 used) => (used.toDouble() / total.toDouble()) * 100;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildRow('CPU', PercentageBarPaint(progress: _calculateCpuUsage(_node.proc.cpu.total, _node.proc.cpu.idle))),
      _buildRow('MEM', PercentageBarPaint(progress: _calculateMemUsage(_node.proc.mem.total, _node.proc.mem.used))),
      _buildRow('ID', Text(_node.id)),
      _buildRow('IP', Text(_node.ip)),
      _buildRow('UPTIME', Text(_node.proc.uptime.toString())),
      _buildRow('OPS', Text(_node.ops.toString())),
    ]);
  }
}

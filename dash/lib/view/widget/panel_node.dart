part of 'panel_node_amal.dart';

// TODO: add sortable header
class NodePanel extends StatelessWidget {
  const NodePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeBloc, NodeState>(buildWhen: (previous, current) => previous != current,
      builder: (context, state) => GridView.builder(itemCount: state.nodes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 11, mainAxisSpacing: 11),
        itemBuilder: (context, index) => AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: NodeCard(node: state.nodes.elementAt(index), last: state.last[state.nodes.elementAt(index).id] ?? Proc())) // TODO: ...
      )
    );
  }
}

class NodeCard extends StatelessWidget {
  const NodeCard({super.key, required Worker node, required Proc last}) : _node = node, _last = last;

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

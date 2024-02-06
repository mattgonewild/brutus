part of 'panel_node_amal.dart';

// TODO: add sortable header
class NodePanel extends StatelessWidget {
  const NodePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeBloc, NodeState>(buildWhen: (previous, current) => true,
      builder: (context, state) => GridView.builder(itemCount: state.nodes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 11, mainAxisSpacing: 11),
        itemBuilder: (context, index) => AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: NodeCard(key: ValueKey(state.nodes.elementAt(index).id), node: state.nodes.elementAt(index)))
      )
    );
  }
}

class NodeCard extends StatelessWidget {
  const NodeCard({super.key, required Worker node}) : _node = node;

  final Worker _node;

  Widget _buildRow(String label, Widget value) => Row(children: [Text(label), Expanded(child: value)]);

  double _calculateCpuUsage(Int64 total, Int64 idle) => ((total - idle).toDouble() / total.toDouble()) * 100;

  double _calculateMemUsage(Int64 total, Int64 used) => (used.toDouble() / total.toDouble()) * 100;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.getNodeCardState(_node.id, _node.type) != current.getNodeCardState(_node.id, _node.type),
      builder: (context, state) => MouseRegion(onEnter: (event) {}, onExit: (event) {},
        child: GestureDetector(onTap: () {},
          child: Card(color: state.getNodeCardState(_node.id, _node.type).backgroundColor, child: Column(children: [
            _buildRow('CPU', PercentageBarPaint(progress: _calculateCpuUsage(_node.proc.cpu.total, _node.proc.cpu.idle))),
            _buildRow('MEM', PercentageBarPaint(progress: _calculateMemUsage(_node.proc.mem.total, _node.proc.mem.used))),
            _buildRow('ID', Text(_node.id, overflow: TextOverflow.ellipsis, maxLines: 1)),
            _buildRow('IP', Text(_node.ip)),
            _buildRow('UPTIME', Text(_node.proc.uptime.toString())),
            _buildRow('OPS', Text(_node.ops.toString())),
          ])),
        ),
      )
    );
  }
}

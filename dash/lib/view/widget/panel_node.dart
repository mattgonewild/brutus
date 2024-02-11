part of 'panel_node_amal.dart';

class NodePanel extends StatelessWidget {
  const NodePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(
        buildWhen: (previous, current) => previous.nodes != current.nodes || previous.nodeCardCrossAxisCount != current.nodeCardCrossAxisCount,
        builder: (context, state) => Column(
              children: [
                // TODO: add sortable header
                Expanded(
                  child: GridView.builder(
                      itemCount: state.nodes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: state.nodeCardCrossAxisCount, crossAxisSpacing: 11, mainAxisSpacing: 11, childAspectRatio: 1.0),
                      itemBuilder: (context, index) => AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: NodeCard(key: ValueKey(state.nodes.elementAt(index).id), node: state.nodes.elementAt(index)))),
                ),
              ],
            ));
  }
}

class NodeCard extends StatelessWidget {
  const NodeCard({super.key, required Worker node}) : _node = node;

  final Worker _node;

  Widget _buildRow(String label, Widget value, {required TextStyle textStyle}) => Expanded(child: Row(children: [Text(label, style: textStyle), Expanded(child: value)]));

  double _calculateCpuUsage(Int64 total, Int64 idle) => ((total - idle).toDouble() / total.toDouble()) * 100;

  double _calculateMemUsage(Int64 total, Int64 used) => (used.toDouble() / total.toDouble()) * 100;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(
        buildWhen: (previous, current) => previous.nodeCardStates[_node.id] != current.nodeCardStates[_node.id] && current.nodeCardStates[_node.id] != null,
        builder: (context, state) => MouseRegion(
              onEnter: (event) {},
              onExit: (event) {},
              child: GestureDetector(
                onTap: () {},
                child: Card(
                    color: state.nodeCardStates[_node.id]!.backgroundColor,
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      _buildRow('CPU', textStyle: state.nodeCardStates[_node.id]!.textStyle, PercentageBarPaint(progress: _calculateCpuUsage(_node.proc.cpu.total, _node.proc.cpu.idle))),
                      _buildRow('MEM', textStyle: state.nodeCardStates[_node.id]!.textStyle, PercentageBarPaint(progress: _calculateMemUsage(_node.proc.mem.total, _node.proc.mem.used))),
                      _buildRow('ID', textStyle: state.nodeCardStates[_node.id]!.textStyle, Text(_node.id, overflow: TextOverflow.ellipsis, maxLines: 1, style: state.nodeCardStates[_node.id]!.textStyle)),
                      _buildRow('IP', textStyle: state.nodeCardStates[_node.id]!.textStyle, Text(_node.ip, overflow: TextOverflow.ellipsis, maxLines: 1, style: state.nodeCardStates[_node.id]!.textStyle)),
                      _buildRow('UPTIME', textStyle: state.nodeCardStates[_node.id]!.textStyle, Text(_node.proc.uptime.toString(), overflow: TextOverflow.ellipsis, maxLines: 1, style: state.nodeCardStates[_node.id]!.textStyle)),
                      _buildRow('OPS', textStyle: state.nodeCardStates[_node.id]!.textStyle, Text(_node.ops.toString(), overflow: TextOverflow.ellipsis, maxLines: 1, style: state.nodeCardStates[_node.id]!.textStyle)),
                    ])),
              ),
            ));
  }
}

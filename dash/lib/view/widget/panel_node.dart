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

  Widget _buildRow(String label, Widget value, {required TextStyle textStyle}) => Expanded(child: Row(children: [Text(label, style: textStyle), Expanded(child: SizedBox.expand(child: value))]));

  double _calculateCpuUsage(Int64 total, Int64 idle) => ((total - idle).toDouble() / total.toDouble()) * 1;

  double _calculateMemUsage(Int64 total, Int64 used) => (used.toDouble() / total.toDouble()) * 1;

  String _formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    return "${f(days)}d ${f(hours)}h ${f(minutes)}m ${f(seconds)}s";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(
        buildWhen: (previous, current) => previous.nodeCardStates[_node.id] != current.nodeCardStates[_node.id] && current.nodeCardStates[_node.id] != null,
        builder: (context, state) => Card(
            color: state.themeData.cardColor,
            clipBehavior: Clip.antiAlias,
            child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [state.nodeCardStates[_node.id]!.typeColor, state.themeData.cardColor],
                  stops: const [0.05, 0.05],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: InkWell(
                  child: LayoutBuilder(
                      builder: (context, constraints) => Padding(
                            padding: EdgeInsets.only(top: constraints.maxHeight * 0.06),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              _buildRow(
                                  'CPU',
                                  textStyle: state.nodeCardStates[_node.id]!.labelTextStyle,
                                  TweenAnimationBuilder<double>(
                                      duration: const Duration(milliseconds: 1000),
                                      tween: Tween<double>(begin: 0, end: _calculateCpuUsage(_node.proc.cpu.total, _node.proc.cpu.idle)),
                                      builder: (context, progress, child) {
                                        return PercentageBarPaint(
                                          progress: progress,
                                          startColor: state.themeData.percentageBarStartColor,
                                          midColor: state.themeData.percentageBarMidColor,
                                          endColor: state.themeData.percentageBarEndColor,
                                        );
                                      })),
                              _buildRow(
                                  'MEM',
                                  textStyle: state.nodeCardStates[_node.id]!.labelTextStyle,
                                  TweenAnimationBuilder<double>(
                                      duration: const Duration(milliseconds: 1000),
                                      tween: Tween<double>(begin: 0, end: _calculateMemUsage(_node.proc.mem.total, _node.proc.mem.used)),
                                      builder: (context, progress, child) {
                                        return PercentageBarPaint(
                                          progress: progress,
                                          startColor: state.themeData.percentageBarStartColor,
                                          midColor: state.themeData.percentageBarMidColor,
                                          endColor: state.themeData.percentageBarEndColor,
                                        );
                                      })),
                              _buildRow(
                                  'ID',
                                  textStyle: state.nodeCardStates[_node.id]!.labelTextStyle,
                                  Center(
                                      child: Text(
                                    _node.id,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: state.nodeCardStates[_node.id]!.bodyTextStyle,
                                  ))),
                              _buildRow(
                                  'IP',
                                  textStyle: state.nodeCardStates[_node.id]!.labelTextStyle,
                                  Center(
                                      child: Text(
                                    _node.ip,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: state.nodeCardStates[_node.id]!.bodyTextStyle,
                                  ))),
                              _buildRow(
                                  'UPTIME',
                                  textStyle: state.nodeCardStates[_node.id]!.labelTextStyle,
                                  Center(
                                      child: Text(
                                    _formatDuration(Duration(milliseconds: _node.proc.uptime.duration.toInt())),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: state.nodeCardStates[_node.id]!.bodyTextStyle,
                                  ))),
                              _buildRow(
                                  'OPS',
                                  textStyle: state.nodeCardStates[_node.id]!.labelTextStyle,
                                  Center(
                                      child: Text(
                                    _node.ops.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: state.nodeCardStates[_node.id]!.bodyTextStyle,
                                  ))),
                            ]),
                          )),
                ))));
  }
}

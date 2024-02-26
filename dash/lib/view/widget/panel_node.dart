part of 'panel_node_amal.dart';

// TODO: batch updates look cheap and are error prone

class NodePanel extends StatelessWidget {
  const NodePanel({super.key});

  Widget _buildHeader() {
    return LayoutBuilder(
        builder: (context, constraints) => BlocBuilder<UIBloc, UIState>(
              buildWhen: (previous, current) => previous.nodePanelHeaderState != current.nodePanelHeaderState,
              builder: (context, state) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildHeaderSelectableButtons(state.nodePanelHeaderState) + _buildHeaderActiveButtons(state.nodePanelHeaderState, constraints: constraints) + _buildHeaderInactiveButtons(state.nodePanelHeaderState, constraints: constraints),
              ),
            ));
  }

  Widget _buildHeaderSelectableButton(NodePanelHeaderBtnBase button) => BlocBuilder<UIBloc, UIState>(
        buildWhen: (previous, current) => previous.nodePanelHeaderState.selectableButtons[button] != current.nodePanelHeaderState.selectableButtons[button],
        builder: (context, state) {
          return Card(
              color: state.nodePanelHeaderState.selectableButtons[button]!.backgroundColor,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    Text(
                      state.nodePanelHeaderState.selectableButtons[button]!.label,
                      style: state.nodePanelHeaderState.selectableButtons[button]!.textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ])));
        },
      );

  Widget _buildHeaderDraggableButton(NodePanelHeaderBtnBase button, {required bool isActive, required BoxConstraints constraints, required index}) {
    Widget buildButton(NodePanelHeaderBtnState btnState) => Card(
        color: btnState.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(children: [
            Expanded(
                flex: 20,
                child: Text(
                  btnState.label,
                  style: btnState.textStyle,
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 5,
                child: FractionallySizedBox(
                  widthFactor: sqrt(constraints.maxWidth * constraints.maxHeight) * 0.0012,
                  child: const SortPaint(
                    topColor: Colors.white,
                    topOpacity: 1.0,
                    bottomColor: Colors.black,
                    bottomOpacity: 0.5,
                  ),
                )),
          ]),
        ));

    return BlocBuilder<UIBloc, UIState>(
      buildWhen: (previous, current) => isActive ? previous.nodePanelHeaderState.activeButtons[button] != current.nodePanelHeaderState.activeButtons[button] : previous.nodePanelHeaderState.inactiveButtons[button] != current.nodePanelHeaderState.inactiveButtons[button],
      builder: (context, state) {
        final NodePanelHeaderBtnState btnState = isActive ? state.nodePanelHeaderState.activeButtons[button]! : state.nodePanelHeaderState.inactiveButtons[button]!;
        return SizedBox(
          width: constraints.maxWidth / 11,
          child: Draggable(
            feedback: SizedBox(
              width: constraints.maxWidth / 11,
              child: buildButton(btnState),
            ),
            childWhenDragging: _buildHeaderPlaceholderButton(
              isActive ? NodePanelHeaderPlaceholderBtn.activeByIndex(index) : NodePanelHeaderPlaceholderBtn.inactiveByIndex(index),
              constraints: constraints,
            ),
            child: buildButton(btnState),
          ),
        );
      },
    );
  }

  Widget _buildHeaderPlaceholderButton(NodePanelHeaderBtnBase button, {required BoxConstraints constraints}) => BlocBuilder<UIBloc, UIState>(
        buildWhen: (previous, current) => previous.nodePanelHeaderState.placeholderButtons[button] != current.nodePanelHeaderState.placeholderButtons[button],
        builder: (context, state) {
          final NodePanelHeaderBtnState btnState = state.nodePanelHeaderState.placeholderButtons[button]!;
          return SizedBox(
              width: constraints.maxWidth / 11,
              child: Card(
                  color: btnState.backgroundColor,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            btnState.label,
                            style: btnState.textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]))));
        },
      );

  List<Widget> _buildHeaderSelectableButtons(NodePanelHeaderState state) => state.selectableButtons.entries.map<Widget>((element) {
        return _buildHeaderSelectableButton(element.key);
      }).toList();

  List<Widget> _buildHeaderActiveButtons(NodePanelHeaderState state, {required BoxConstraints constraints}) => List<Widget>.generate(4, (index) {
        if (index < state.activeButtons.length) {
          return _buildHeaderDraggableButton(state.activeButtons.entries.elementAt(index).key, isActive: true, constraints: constraints, index: index);
        } else {
          return _buildHeaderPlaceholderButton(NodePanelHeaderPlaceholderBtn.activeByIndex(index), constraints: constraints);
        }
      });

  List<Widget> _buildHeaderInactiveButtons(NodePanelHeaderState state, {required BoxConstraints constraints}) => List<Widget>.generate(4, (index) {
        if (index < state.inactiveButtons.length) {
          return _buildHeaderDraggableButton(state.inactiveButtons.entries.elementAt(index).key, isActive: false, constraints: constraints, index: index);
        } else {
          return _buildHeaderPlaceholderButton(NodePanelHeaderPlaceholderBtn.inactiveByIndex(index), constraints: constraints);
        }
      });

  Widget _buildGrid() => BlocBuilder<UIBloc, UIState>(
      buildWhen: (previous, current) => previous.nodes != current.nodes || previous.nodeCardCrossAxisCount != current.nodeCardCrossAxisCount,
      builder: (context, state) => GridView.builder(
            itemCount: state.nodes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: state.nodeCardCrossAxisCount, crossAxisSpacing: 11, mainAxisSpacing: 11, childAspectRatio: 1.0),
            itemBuilder: (context, index) => AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: NodeCard(key: ValueKey(state.nodes.elementAt(index).id), node: state.nodes.elementAt(index))),
          ));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: _buildHeader(),
        ),
        Expanded(
          flex: 10,
          child: _buildGrid(),
        ),
      ],
    );
  }
}

class NodeCard extends StatelessWidget {
  const NodeCard({super.key, required Worker node}) : _node = node;

  final Worker _node;

  Widget _buildRow(String label, Widget value, {required TextStyle textStyle, Widget trailing = const SizedBox.shrink()}) => Expanded(
        child: Row(children: [Text(label, style: textStyle), Expanded(child: SizedBox.expand(child: value)), trailing]),
      );

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
                                )),
                                trailing: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: FractionallySizedBox(
                                        widthFactor: 0.5,
                                        heightFactor: 0.5,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          onEnter: (_) => context.read<UIBloc>().add(NodeCardIDCopyHovered(_node.id)),
                                          onExit: (_) => context.read<UIBloc>().add(NodeCardIDCopyUnhovered(_node.id)),
                                          child: GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(text: _node.id));
                                            },
                                            child: CopyPaint(
                                              color: state.nodeCardStates[_node.id]!.idCopyPaintColor,
                                              opacity: state.nodeCardStates[_node.id]!.idCopyPaintOpacity,
                                            ),
                                          ),
                                        ))),
                              ),
                              _buildRow(
                                'IP',
                                textStyle: state.nodeCardStates[_node.id]!.labelTextStyle,
                                Center(
                                    child: Text(
                                  _node.ip,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: state.nodeCardStates[_node.id]!.bodyTextStyle,
                                )),
                                trailing: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: FractionallySizedBox(
                                      widthFactor: 0.5,
                                      heightFactor: 0.5,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        onEnter: (_) => context.read<UIBloc>().add(NodeCardIPCopyHovered(_node.id)),
                                        onExit: (_) => context.read<UIBloc>().add(NodeCardIPCopyUnhovered(_node.id)),
                                        child: GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(text: _node.ip));
                                          },
                                          child: CopyPaint(
                                            color: state.nodeCardStates[_node.id]!.ipCopyPaintColor,
                                            opacity: state.nodeCardStates[_node.id]!.ipCopyPaintOpacity,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
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

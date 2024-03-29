part of 'ui_amal.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  UIBloc({required SysBloc sysBloc, required NodeBloc nodeBloc})
      : _sysBloc = sysBloc,
        _nodeBloc = nodeBloc,
        super(UIState()) {
    _sysBlocSubscription = _sysBloc.stream.listen((SysState state) {
      switch (state) {
        case SysState.running:
          add(const ARBStartOn());
        case SysState.stopped:
          add(const ARBStartOff());
        case SysState.unknown:
          add(const ARBStartOff());
      }
    });

    _nodeBlocSubscription = _nodeBloc.stream.listen((NodeState state) {
      add(NodeStateUpdated(state));
    });

    on<NodeStateUpdated>(_onNodeStateUpdated);

    on<LayoutConstraintsUpdated>(_onLayoutConstraintsChanged);

    on<ARBHovered>(_onARBHovered);
    on<ARBUnhovered>(_onARBUnhovered);

    on<ARBStartPressed>(_onARBStartPressed);
    on<ARBStartOn>(_onARBStartOn);
    on<ARBStartOff>(_onARBStartOff);
    on<ARBStopPressed>(_onARBStopPressed);
    on<ARBStopOn>(_onARBStopOn);
    on<ARBStopOff>(_onARBStopOff);
    on<ARBLogPressed>(_onARBLogPressed);
    on<ARBLogOn>(_onARBLogOn);
    on<ARBLogOff>(_onARBLogOff);
    on<ARBSettingsPressed>(_onARBSettingsPressed);
    on<ARBSettingsOn>(_onARBSettingsOn);
    on<ARBSettingsOff>(_onARBSettingsOff);

    on<NodePanelHeaderTargetOnWillAcceptWithDetails>(_onNodePanelHeaderTargetOnWillAcceptWithDetails);
    on<NodePanelHeaderTargetOnAcceptWithDetails>(_onNodePanelHeaderTargetOnAcceptWithDetails);
    on<NodePanelHeaderTargetOnLeave>(_onNodePanelHeaderTargetOnLeave);

    on<NodeCardIDCopyHovered>(_onNodeCardIDCopyHovered);
    on<NodeCardIDCopyUnhovered>(_onNodeCardIDCopyUnhovered);
    on<NodeCardIPCopyHovered>(_onNodeCardIPCopyHovered);
    on<NodeCardIPCopyUnhovered>(_onNodeCardIPCopyUnhovered);
  }

  final SysBloc _sysBloc;
  late StreamSubscription<SysState> _sysBlocSubscription;

  final NodeBloc _nodeBloc;
  late StreamSubscription<NodeState> _nodeBlocSubscription;

  Future<void> _onNodeStateUpdated(NodeStateUpdated event, Emitter<UIState> emit) async {
    final List<Worker> nodes = event.nodeState.nodes.toList(growable: false);
    final Set<String> ids = nodes.map((e) => e.id).toSet();
    final HashMap<String, NodeCardState> nodeCardStates = state.nodeCardStates;

    nodeCardStates.removeWhere((key, value) => !ids.contains(key));

    for (final node in nodes) {
      nodeCardStates.putIfAbsent(node.id, () => NodeCardState.defaultState(type: node.type, bodyTextStyle: state.themeData.bodySmall, labelTextStyle: state.themeData.labelMedium));
    }

    emit(state.copyWith(nodes: nodes, nodeCardStates: nodeCardStates));
  }

  Future<void> _onLayoutConstraintsChanged(LayoutConstraintsUpdated event, Emitter<UIState> emit) async {
    double calculateFontSize(double ratio) => sqrt(event.maxWidth * event.maxHeight) * ratio;

    TextStyle updateTextStyle(TextStyle style, double ratio) => style.copyWith(fontSize: calculateFontSize(ratio));

    final UIThemeData themeData = state.themeData.copyWith(
        displayLarge: updateTextStyle(state.themeData.displayLarge, __displayLargeFontHeightRatio),
        displayMedium: updateTextStyle(state.themeData.displayMedium, __displayMediumFontHeightRatio),
        displaySmall: updateTextStyle(state.themeData.displaySmall, __displaySmallFontHeightRatio),
        headlineLarge: updateTextStyle(state.themeData.headlineLarge, __headlineLargeFontHeightRatio),
        headlineMedium: updateTextStyle(state.themeData.headlineMedium, __headlineMediumFontHeightRatio),
        headlineSmall: updateTextStyle(state.themeData.headlineSmall, __headlineSmallFontHeightRatio),
        titleLarge: updateTextStyle(state.themeData.titleLarge, __titleLargeFontHeightRatio),
        titleMedium: updateTextStyle(state.themeData.titleMedium, __titleMediumFontHeightRatio),
        titleSmall: updateTextStyle(state.themeData.titleSmall, __titleSmallFontHeightRatio),
        labelLarge: updateTextStyle(state.themeData.labelLarge, __labelLargeFontHeightRatio),
        labelMedium: updateTextStyle(state.themeData.labelMedium, __labelMediumFontHeightRatio),
        labelSmall: updateTextStyle(state.themeData.labelSmall, __labelSmallFontHeightRatio),
        bodyLarge: updateTextStyle(state.themeData.bodyLarge, __bodyLargeFontHeightRatio),
        bodyMedium: updateTextStyle(state.themeData.bodyMedium, __bodyMediumFontHeightRatio),
        bodySmall: updateTextStyle(state.themeData.bodySmall, __bodySmallFontHeightRatio));

    final HashMap<String, NodeCardState> nodeCardStates = state.nodeCardStates;
    nodeCardStates.forEach((key, value) {
      nodeCardStates[key] = value.copyWith(bodyTextStyle: updateTextStyle(value.bodyTextStyle, __bodySmallFontHeightRatio), labelTextStyle: updateTextStyle(value.labelTextStyle, __labelMediumFontHeightRatio));
    });

    final LinkedHashMap<ActionRailButtons, ActionRailButtonState> actionRailButtonStates = state.actionRailButtonStates;
    actionRailButtonStates.forEach((key, value) {
      actionRailButtonStates[key] = value.copyWith(textStyle: updateTextStyle(value.textStyle, __labelMediumFontHeightRatio));
    });

    final List<NodePanelHeaderBtnState> btnStateTemp = state.nodePanelHeaderState.btnStateTemp.map((e) => e.copyWith(textStyle: updateTextStyle(e.textStyle, __labelMediumFontHeightRatio))).toList();
    final List<NodePanelHeaderBtnState> childWhenDragging = state.nodePanelHeaderState.childWhenDragging.map((e) => e.copyWith(textStyle: updateTextStyle(e.textStyle, __labelMediumFontHeightRatio))).toList();
    final List<NodePanelHeaderBtnState> btnStatePerm = state.nodePanelHeaderState.btnStatePerm.map((e) => e.copyWith(textStyle: updateTextStyle(e.textStyle, __labelMediumFontHeightRatio))).toList();

    emit(state.copyWith(
      screenMaxWidth: event.maxWidth,
      screenMaxHeight: event.maxHeight,
      nodeCardCrossAxisCount: max(4, (event.maxWidth / event.maxHeight * 1.64).floor()),
      nodeCardStates: nodeCardStates,
      actionRailButtonStates: actionRailButtonStates,
      nodePanelHeaderState: NodePanelHeaderState(
        themeData: themeData,
        btnStateTemp: btnStateTemp,
        childWhenDragging: childWhenDragging,
        btnStatePerm: btnStatePerm,
      ),
      themeData: themeData,
    ));
  }

  Future<void> _updateARBbackgroundColor(ActionRailButtons button, Color color, Emitter<UIState> emit) async {
    final LinkedHashMap<ActionRailButtons, ActionRailButtonState> actionRailButtonStates = state.actionRailButtonStates;
    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates..[button] = actionRailButtonStates[button]!.copyWith(backgroundColor: color)));
  }

  Future<void> _onARBHovered(ARBHovered event, Emitter<UIState> emit) async {
    _updateARBbackgroundColor(event.button, __cardHoverColor, emit);
  }

  Future<void> _onARBUnhovered(ARBUnhovered event, Emitter<UIState> emit) async {
    _updateARBbackgroundColor(event.button, __cardColor, emit);
  }

  Future<void> _updateARBState(ActionRailButtons button, ButtonState buttonState, Emitter<UIState> emit) async {
    final LinkedHashMap<ActionRailButtons, ActionRailButtonState> actionRailButtonStates = state.actionRailButtonStates;
    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates..[button] = actionRailButtonStates[button]!.copyWith(buttonState: buttonState)));
  }

  Future<void> _onARBStartPressed(ARBStartPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.startRequested);
    _updateARBState(ActionRailButtons.start, ButtonState.thinking, emit);
  }

  Future<void> _onARBStartOn(ARBStartOn event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.start, ButtonState.selected, emit);
  }

  Future<void> _onARBStartOff(ARBStartOff event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.start, ButtonState.unselected, emit);
  }

  Future<void> _onARBStopPressed(ARBStopPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.stopRequested);
    _updateARBState(ActionRailButtons.stop, ButtonState.thinking, emit);
  }

  Future<void> _onARBStopOn(ARBStopOn event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.stop, ButtonState.selected, emit);
  }

  Future<void> _onARBStopOff(ARBStopOff event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.stop, ButtonState.unselected, emit);
  }

  Future<void> _onARBLogPressed(ARBLogPressed event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.log, ButtonState.thinking, emit);
  }

  Future<void> _onARBLogOn(ARBLogOn event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.log, ButtonState.selected, emit);
  }

  Future<void> _onARBLogOff(ARBLogOff event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.log, ButtonState.unselected, emit);
  }

  Future<void> _onARBSettingsPressed(ARBSettingsPressed event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.settings, ButtonState.thinking, emit);
  }

  Future<void> _onARBSettingsOn(ARBSettingsOn event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.settings, ButtonState.selected, emit);
  }

  Future<void> _onARBSettingsOff(ARBSettingsOff event, Emitter<UIState> emit) async {
    _updateARBState(ActionRailButtons.settings, ButtonState.unselected, emit);
  }

  Future<void> _onNodePanelHeaderTargetOnWillAcceptWithDetails(NodePanelHeaderTargetOnWillAcceptWithDetails event, Emitter<UIState> emit) async {
    final List<NodePanelHeaderBtnState> btnStateTemp = state.nodePanelHeaderState.btnStateTemp;
    final List<NodePanelHeaderBtnState> btnStatePerm = state.nodePanelHeaderState.btnStatePerm;
  }

  Future<void> _onNodePanelHeaderTargetOnAcceptWithDetails(NodePanelHeaderTargetOnAcceptWithDetails event, Emitter<UIState> emit) async {
    emit(state.copyWith(nodePanelHeaderState: state.nodePanelHeaderState.apply(themeData: state.themeData)));
  }

  Future<void> _onNodePanelHeaderTargetOnLeave(NodePanelHeaderTargetOnLeave event, Emitter<UIState> emit) async {
    emit(state.copyWith(nodePanelHeaderState: state.nodePanelHeaderState.revert(themeData: state.themeData)));
  }

  Future<void> _onNodeCardIDCopyHovered(NodeCardIDCopyHovered event, Emitter<UIState> emit) async {
    if (state.nodeCardStates[event.id] != null) {
      emit(state.copyWith(nodeCardStates: state.nodeCardStates..[event.id] = state.nodeCardStates[event.id]!.copyWith(idCopyPaintOpacity: 1.0)));
    }
  }

  Future<void> _onNodeCardIDCopyUnhovered(NodeCardIDCopyUnhovered event, Emitter<UIState> emit) async {
    if (state.nodeCardStates[event.id] != null) {
      emit(state.copyWith(nodeCardStates: state.nodeCardStates..[event.id] = state.nodeCardStates[event.id]!.copyWith(idCopyPaintOpacity: 0.25)));
    }
  }

  Future<void> _onNodeCardIPCopyHovered(NodeCardIPCopyHovered event, Emitter<UIState> emit) async {
    if (state.nodeCardStates[event.id] != null) {
      emit(state.copyWith(nodeCardStates: state.nodeCardStates..[event.id] = state.nodeCardStates[event.id]!.copyWith(ipCopyPaintOpacity: 1.0)));
    }
  }

  Future<void> _onNodeCardIPCopyUnhovered(NodeCardIPCopyUnhovered event, Emitter<UIState> emit) async {
    if (state.nodeCardStates[event.id] != null) {
      emit(state.copyWith(nodeCardStates: state.nodeCardStates..[event.id] = state.nodeCardStates[event.id]!.copyWith(ipCopyPaintOpacity: 0.25)));
    }
  }

  @override
  Future<void> close() {
    _sysBlocSubscription.cancel();
    _nodeBlocSubscription.cancel();
    return super.close();
  }
}

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
  }

  final SysBloc _sysBloc;
  late StreamSubscription<SysState> _sysBlocSubscription;

  final NodeBloc _nodeBloc;
  late StreamSubscription<NodeState> _nodeBlocSubscription;

  Future<void> _onNodeStateUpdated(NodeStateUpdated event, Emitter<UIState> emit) async {
    final List<Worker> nodes = event.nodeState.nodes.toList(growable: false);
    final Set<String> ids = nodes.map((e) => e.id).toSet();
    final HashMap<String, NodeCardState> nodeCardStates = HashMap<String, NodeCardState>.from(state.nodeCardStates);

    nodeCardStates.removeWhere((key, value) => !ids.contains(key));

    for (final node in nodes) {
      nodeCardStates.putIfAbsent(node.id, () => NodeCardState.defaultState(node.type, state.bodyMedium));
    }

    emit(state.copyWith(nodes: nodes, nodeCardStates: nodeCardStates));
  }

  Future<void> _onLayoutConstraintsChanged(LayoutConstraintsUpdated event, Emitter<UIState> emit) async {
    final TextStyle displayLarge = state.displayLarge.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __displayLargeFontHeightRatio);
    final TextStyle displayMedium = state.displayMedium.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __displayMediumFontHeightRatio);
    final TextStyle displaySmall = state.displaySmall.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __displaySmallFontHeightRatio);
    final TextStyle headlineLarge = state.headlineLarge.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __headlineLargeFontHeightRatio);
    final TextStyle headlineMedium = state.headlineMedium.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __headlineMediumFontHeightRatio);
    final TextStyle headlineSmall = state.headlineSmall.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __headlineSmallFontHeightRatio);
    final TextStyle titleLarge = state.titleLarge.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __titleLargeFontHeightRatio);
    final TextStyle titleMedium = state.titleMedium.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __titleMediumFontHeightRatio);
    final TextStyle titleSmall = state.titleSmall.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __titleSmallFontHeightRatio);
    final TextStyle labelLarge = state.labelLarge.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __labelLargeFontHeightRatio);
    final TextStyle labelMedium = state.labelMedium.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __labelMediumFontHeightRatio);
    final TextStyle labelSmall = state.labelSmall.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __labelSmallFontHeightRatio);
    final TextStyle bodyLarge = state.bodyLarge.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __bodyLargeFontHeightRatio);
    final TextStyle bodyMedium = state.bodyMedium.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __bodyMediumFontHeightRatio);
    final TextStyle bodySmall = state.bodySmall.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __bodySmallFontHeightRatio);

    final HashMap<String, NodeCardState> nodeCardStates = HashMap<String, NodeCardState>.from(state.nodeCardStates);
    nodeCardStates.forEach((key, value) {
      nodeCardStates[key] = value.copyWith(textStyle: value.textStyle.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __bodyMediumFontHeightRatio));
    });

    final LinkedHashMap<ActionRailButtons, ActionRailButtonState> actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates.forEach((key, value) {
      actionRailButtonStates[key] = value.copyWith(textStyle: value.textStyle.copyWith(fontSize: sqrt(event.maxWidth * event.maxHeight) * __labelMediumFontHeightRatio));
    });

    emit(state.copyWith(
      screenMaxWidth: event.maxWidth,
      screenMaxHeight: event.maxHeight,
      nodeCardCrossAxisCount: max(4, (event.maxWidth / event.maxHeight * 1.64 ).floor()),
      nodeCardStates: nodeCardStates,
      actionRailButtonStates: actionRailButtonStates,
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ));
  }

  Future<void> _onARBStartPressed(ARBStartPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.startRequested);

    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.start] = actionRailButtonStates[ActionRailButtons.start]!.copyWith(buttonState: ButtonState.thinking);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBStartOn(ARBStartOn event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.start] = actionRailButtonStates[ActionRailButtons.start]!.copyWith(buttonState: ButtonState.selected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBStartOff(ARBStartOff event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.start] = actionRailButtonStates[ActionRailButtons.start]!.copyWith(buttonState: ButtonState.unselected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBStopPressed(ARBStopPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.stopRequested);

    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.stop] = actionRailButtonStates[ActionRailButtons.stop]!.copyWith(buttonState: ButtonState.thinking);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBStopOn(ARBStopOn event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.stop] = actionRailButtonStates[ActionRailButtons.stop]!.copyWith(buttonState: ButtonState.selected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBStopOff(ARBStopOff event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.stop] = actionRailButtonStates[ActionRailButtons.stop]!.copyWith(buttonState: ButtonState.unselected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBLogPressed(ARBLogPressed event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.log] = actionRailButtonStates[ActionRailButtons.log]!.copyWith(buttonState: ButtonState.thinking);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBLogOn(ARBLogOn event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.log] = actionRailButtonStates[ActionRailButtons.log]!.copyWith(buttonState: ButtonState.selected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBLogOff(ARBLogOff event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.log] = actionRailButtonStates[ActionRailButtons.log]!.copyWith(buttonState: ButtonState.unselected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBSettingsPressed(ARBSettingsPressed event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.settings] = actionRailButtonStates[ActionRailButtons.settings]!.copyWith(buttonState: ButtonState.thinking);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBSettingsOn(ARBSettingsOn event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.settings] = actionRailButtonStates[ActionRailButtons.settings]!.copyWith(buttonState: ButtonState.selected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  Future<void> _onARBSettingsOff(ARBSettingsOff event, Emitter<UIState> emit) async {
    final actionRailButtonStates = LinkedHashMap<ActionRailButtons, ActionRailButtonState>.from(state.actionRailButtonStates);
    actionRailButtonStates[ActionRailButtons.settings] = actionRailButtonStates[ActionRailButtons.settings]!.copyWith(buttonState: ButtonState.unselected);

    emit(state.copyWith(actionRailButtonStates: actionRailButtonStates));
  }

  @override
  Future<void> close() {
    _sysBlocSubscription.cancel();
    _nodeBlocSubscription.cancel();
    return super.close();
  }
}

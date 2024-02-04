part of 'ui_amal.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  UIBloc({required SysBloc sysBloc}) : _sysBloc = sysBloc, super(UIState()) {
    _sysBlocSubscription = _sysBloc.stream.listen((SysState state) {
      switch (state) {
        case SysState.running: add(const ARBStartOn());
        case SysState.stopped: add(const ARBStartOff());
        case SysState.unknown: add(const ARBStartOff());
      }
    });
    
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

  Future<void> _onARBStartPressed(ARBStartPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.startRequested);
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.start] = state.getActionRailButtonState(ActionRailButtons.start).copyWith(buttonState: ButtonState.thinking)));
  }

  Future<void> _onARBStartOn(ARBStartOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.start] = state.getActionRailButtonState(ActionRailButtons.start).copyWith(buttonState: ButtonState.selected)));
  }

  Future<void> _onARBStartOff(ARBStartOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.start] = state.getActionRailButtonState(ActionRailButtons.start).copyWith(buttonState: ButtonState.unselected)));
  }

  Future<void> _onARBStopPressed(ARBStopPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.stopRequested);
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.stop] = state.getActionRailButtonState(ActionRailButtons.stop).copyWith(buttonState: ButtonState.thinking)));
  }

  Future<void> _onARBStopOn(ARBStopOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.stop] = state.getActionRailButtonState(ActionRailButtons.stop).copyWith(buttonState: ButtonState.selected)));
  }

  Future<void> _onARBStopOff(ARBStopOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.stop] = state.getActionRailButtonState(ActionRailButtons.stop).copyWith(buttonState: ButtonState.unselected)));
  }

  Future<void> _onARBLogPressed(ARBLogPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.log] = state.getActionRailButtonState(ActionRailButtons.log).copyWith(buttonState: ButtonState.thinking)));
  }

  Future<void> _onARBLogOn(ARBLogOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.log] = state.getActionRailButtonState(ActionRailButtons.log).copyWith(buttonState: ButtonState.selected)));
  }

  Future<void> _onARBLogOff(ARBLogOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.log] = state.getActionRailButtonState(ActionRailButtons.log).copyWith(buttonState: ButtonState.unselected)));
  }

  Future<void> _onARBSettingsPressed(ARBSettingsPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.settings] = state.getActionRailButtonState(ActionRailButtons.settings).copyWith(buttonState: ButtonState.thinking)));
  }

  Future<void> _onARBSettingsOn(ARBSettingsOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.settings] = state.getActionRailButtonState(ActionRailButtons.settings).copyWith(buttonState: ButtonState.selected)));
  }

  Future<void> _onARBSettingsOff(ARBSettingsOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(actionRailButtonStates: state.actionRailButtonStates..[ActionRailButtons.settings] = state.getActionRailButtonState(ActionRailButtons.settings).copyWith(buttonState: ButtonState.unselected)));
  }

  @override
  Future<void> close() {
    _sysBlocSubscription.cancel();
    return super.close();
  }
}

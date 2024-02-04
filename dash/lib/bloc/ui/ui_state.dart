// ignore_for_file: non_constant_identifier_names

part of 'ui_amal.dart';

const TextStyle defaultTextStyle = TextStyle();

enum ButtonState { unselected, thinking, selected }

enum RegionState { inRegion, outRegion }

enum ActionRailButtons { start, stop, log, settings }

final class UIState extends Equatable {
  UIState({
      int? UIStateVersion,
      LinkedHashMap<ActionRailButtons, ActionRailButtonState>? actionRailButtonStates,
      HashMap<String, NodeCardState>? nodeCardStates
  }): _UIStateVersion = UIStateVersion ?? 0,
      _actionRailButtonStates = actionRailButtonStates ?? LinkedHashMap<ActionRailButtons, ActionRailButtonState>.fromIterables(ActionRailButtons.values, List<ActionRailButtonState>.filled(ActionRailButtons.values.length, const ActionRailButtonState())),
      _nodeCardStates = nodeCardStates ?? HashMap<String, NodeCardState>()
    ;

  final int _UIStateVersion;

  final LinkedHashMap<ActionRailButtons, ActionRailButtonState> _actionRailButtonStates;
  LinkedHashMap<ActionRailButtons, ActionRailButtonState> get actionRailButtonStates => _actionRailButtonStates;
  final HashMap<String, NodeCardState> _nodeCardStates;
  HashMap<String, NodeCardState> get nodeCardStates => _nodeCardStates;

  UIState copyWith({
    int? UIStateVersion,
    LinkedHashMap<ActionRailButtons, ActionRailButtonState>? actionRailButtonStates,
    HashMap<String, NodeCardState>? nodeCardStates
  }) => UIState(
    UIStateVersion: UIStateVersion ?? _UIStateVersion + 1,
    actionRailButtonStates: actionRailButtonStates ?? _actionRailButtonStates,
    nodeCardStates: nodeCardStates ?? _nodeCardStates
  );
  
  @override
  List<Object> get props => [_UIStateVersion];
}

final class ActionRailButtonState extends Equatable {
  const ActionRailButtonState({
      RegionState? regionState,
      ButtonState? buttonState,
      Color? backgroundColor,
      Color? iconColor,
      TextStyle? textStyle
  }): _regionState = regionState ?? RegionState.outRegion,
      _buttonState = buttonState ?? ButtonState.unselected,
      _backgroundColor = backgroundColor ?? Colors.transparent,
      _iconColor = iconColor ?? Colors.black,
      _textStyle = textStyle ?? defaultTextStyle
    ;

  final RegionState _regionState;
  final ButtonState _buttonState;
  final Color _backgroundColor;
  Color get backgroundColor => _backgroundColor;
  final Color _iconColor;
  Color get iconColor => _iconColor;
  final TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;

  ActionRailButtonState copyWith({
    RegionState? regionState,
    ButtonState? buttonState,
    Color? backgroundColor,
    Color? iconColor,
    TextStyle? textStyle
  }) => ActionRailButtonState(
    regionState: regionState ?? _regionState,
    buttonState: buttonState ?? _buttonState,
    backgroundColor: backgroundColor ?? _backgroundColor,
    iconColor: iconColor ?? _iconColor,
    textStyle: textStyle ?? _textStyle
  );
  
  @override
  List<Object> get props => [_backgroundColor, _iconColor, _textStyle];
}

final class NodeCardState extends Equatable {
  const NodeCardState({
      RegionState? regionState,
      ButtonState? buttonState,
      Color? backgroundColor,
      TextStyle? textStyle
  }): _regionState = regionState ?? RegionState.outRegion,
      _buttonState = buttonState ?? ButtonState.unselected,
      _backgroundColor = backgroundColor ?? Colors.transparent,
      _textStyle = textStyle ?? defaultTextStyle
    ;

  final RegionState _regionState;
  final ButtonState _buttonState;
  final Color _backgroundColor;
  Color get backgroundColor => _backgroundColor;
  final TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;

  NodeCardState copyWith({
    RegionState? regionState,
    ButtonState? buttonState,
    Color? backgroundColor
  }) => NodeCardState(
    regionState: regionState ?? _regionState,
    buttonState: buttonState ?? _buttonState,
    backgroundColor: backgroundColor ?? _backgroundColor
  );
  
  @override
  List<Object> get props => [_backgroundColor, _textStyle];
}

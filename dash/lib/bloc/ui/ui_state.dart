// ignore_for_file: non_constant_identifier_names, prefer_collection_literals
// TODO: this is really bad

part of 'ui_amal.dart';

const double __displayLargeFontHeightRatio = 0.095;
const double __displayMediumFontHeightRatio = 0.075;
const double __displaySmallFontHeightRatio = 0.055;
const double __headlineLargeFontHeightRatio = 0.075;
const double __headlineMediumFontHeightRatio = 0.055;
const double __headlineSmallFontHeightRatio = 0.035;
const double __titleLargeFontHeightRatio = 0.055;
const double __titleMediumFontHeightRatio = 0.035;
const double __titleSmallFontHeightRatio = 0.025;
const double __labelLargeFontHeightRatio = 0.035;
const double __labelMediumFontHeightRatio = 0.025;
const double __labelSmallFontHeightRatio = 0.015;
const double __bodyLargeFontHeightRatio = 0.035;
const double __bodyMediumFontHeightRatio = 0.025;
const double __bodySmallFontHeightRatio = 0.015;

const TextStyle __displayLarge = TextStyle(fontWeight: FontWeight.bold);
const TextStyle __displayMedium = TextStyle(fontWeight: FontWeight.bold);
const TextStyle __displaySmall = TextStyle(fontWeight: FontWeight.bold);
const TextStyle __headlineLarge = TextStyle(fontWeight: FontWeight.bold);
const TextStyle __headlineMedium = TextStyle(fontWeight: FontWeight.bold);
const TextStyle __headlineSmall = TextStyle(fontWeight: FontWeight.bold);
const TextStyle __titleLarge = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __titleMedium = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __titleSmall = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __labelLarge = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __labelMedium = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __labelSmall = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __bodyLarge = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __bodyMedium = TextStyle(fontWeight: FontWeight.normal);
const TextStyle __bodySmall = TextStyle(fontWeight: FontWeight.normal);

enum ButtonState { unselected, thinking, selected }

enum RegionState { inRegion, outRegion }

enum ActionRailButtons { start, stop, log, settings }

final class UIState extends Equatable {
  UIState(
      {int? UIStateVersion,
      double? screenMaxWidth,
      double? screenMaxHeight,
      Color? canvasColor,
      Color? cardColor,
      TextStyle? displayLarge,
      TextStyle? displayMedium,
      TextStyle? displaySmall,
      TextStyle? headlineLarge,
      TextStyle? headlineMedium,
      TextStyle? headlineSmall,
      TextStyle? titleLarge,
      TextStyle? titleMedium,
      TextStyle? titleSmall,
      TextStyle? labelLarge,
      TextStyle? labelMedium,
      TextStyle? labelSmall,
      TextStyle? bodyLarge,
      TextStyle? bodyMedium,
      TextStyle? bodySmall,
      LinkedHashMap<ActionRailButtons, ActionRailButtonState>? actionRailButtonStates,
      List<Worker>? nodes,
      HashMap<String, NodeCardState>? nodeCardStates,
      int? nodeCardCrossAxisCount})
      : _UIStateVersion = UIStateVersion ?? 0,
        _screenMaxWidth = screenMaxWidth ?? 800,
        _screenMaxHeight = screenMaxHeight ?? 600,
        _canvasColor = canvasColor ?? const Color.fromRGBO(21, 22, 27, 1.0),
        _cardColor = cardColor ?? const Color.fromRGBO(48, 52, 63, 1.0),
        _displayLarge = displayLarge ?? __displayLarge,
        _displayMedium = displayMedium ?? __displayMedium,
        _displaySmall = displaySmall ?? __displaySmall,
        _headlineLarge = headlineLarge ?? __headlineLarge,
        _headlineMedium = headlineMedium ?? __headlineMedium,
        _headlineSmall = headlineSmall ?? __headlineSmall,
        _titleLarge = titleLarge ?? __titleLarge,
        _titleMedium = titleMedium ?? __titleMedium,
        _titleSmall = titleSmall ?? __titleSmall,
        _labelLarge = labelLarge ?? __labelLarge,
        _labelMedium = labelMedium ?? __labelMedium,
        _labelSmall = labelSmall ?? __labelSmall,
        _bodyLarge = bodyLarge ?? __bodyLarge,
        _bodyMedium = bodyMedium ?? __bodyMedium,
        _bodySmall = bodySmall ?? __bodySmall,
        _actionRailButtonStates = actionRailButtonStates ??
            LinkedHashMap.fromIterable(
              ActionRailButtons.values,
              key: (button) => button,
              value: (button) => ActionRailButtonState.defaultState(__labelMedium),
            ),
        _nodes = nodes ?? <Worker>[],
        _nodeCardStates = nodeCardStates ?? HashMap<String, NodeCardState>(),
        _nodeCardCrossAxisCount = nodeCardCrossAxisCount ?? 4;

  final int _UIStateVersion;
  final double _screenMaxWidth;
  double get screenMaxWidth => _screenMaxWidth;
  final double _screenMaxHeight;
  double get screenMaxHeight => _screenMaxHeight;

  final Color _canvasColor;
  Color get canvasColor => _canvasColor;
  final Color _cardColor;
  Color get cardColor => _cardColor;

  final TextStyle _displayLarge;
  TextStyle get displayLarge => _displayLarge;
  final TextStyle _displayMedium;
  TextStyle get displayMedium => _displayMedium;
  final TextStyle _displaySmall;
  TextStyle get displaySmall => _displaySmall;

  final TextStyle _headlineLarge;
  TextStyle get headlineLarge => _headlineLarge;
  final TextStyle _headlineMedium;
  TextStyle get headlineMedium => _headlineMedium;
  final TextStyle _headlineSmall;
  TextStyle get headlineSmall => _headlineSmall;

  final TextStyle _titleLarge;
  TextStyle get titleLarge => _titleLarge;
  final TextStyle _titleMedium;
  TextStyle get titleMedium => _titleMedium;
  final TextStyle _titleSmall;
  TextStyle get titleSmall => _titleSmall;

  final TextStyle _labelLarge;
  TextStyle get labelLarge => _labelLarge;
  final TextStyle _labelMedium;
  TextStyle get labelMedium => _labelMedium;
  final TextStyle _labelSmall;
  TextStyle get labelSmall => _labelSmall;

  final TextStyle _bodyLarge;
  TextStyle get bodyLarge => _bodyLarge;
  final TextStyle _bodyMedium;
  TextStyle get bodyMedium => _bodyMedium;
  final TextStyle _bodySmall;
  TextStyle get bodySmall => _bodySmall;

  final LinkedHashMap<ActionRailButtons, ActionRailButtonState> _actionRailButtonStates; // TODO: ...
  /// do not try to modify the list directly, it will cause a runtime error
  Map<ActionRailButtons, ActionRailButtonState> get actionRailButtonStates => Map.unmodifiable(_actionRailButtonStates);

  final List<Worker> _nodes;
  /// do not try to modify the list directly, it will cause a runtime error
  List<Worker> get nodes => List.unmodifiable(_nodes);

  final HashMap<String, NodeCardState> _nodeCardStates;
  /// do not try to modify the list directly, it will cause a runtime error
  Map<String, NodeCardState> get nodeCardStates => Map.unmodifiable(_nodeCardStates);

  final int _nodeCardCrossAxisCount;
  int get nodeCardCrossAxisCount => _nodeCardCrossAxisCount;

  UIState copyWith(
          {int? UIStateVersion,
          double? screenMaxWidth,
          double? screenMaxHeight,
          Color? canvasColor,
          Color? cardColor,
          TextStyle? displayLarge,
          TextStyle? displayMedium,
          TextStyle? displaySmall,
          TextStyle? headlineLarge,
          TextStyle? headlineMedium,
          TextStyle? headlineSmall,
          TextStyle? titleLarge,
          TextStyle? titleMedium,
          TextStyle? titleSmall,
          TextStyle? labelLarge,
          TextStyle? labelMedium,
          TextStyle? labelSmall,
          TextStyle? bodyLarge,
          TextStyle? bodyMedium,
          TextStyle? bodySmall,
          LinkedHashMap<ActionRailButtons, ActionRailButtonState>? actionRailButtonStates,
          List<Worker>? nodes,
          HashMap<String, NodeCardState>? nodeCardStates,
          int? nodeCardCrossAxisCount}) =>
      UIState(
          UIStateVersion: UIStateVersion ?? _UIStateVersion + 1,
          screenMaxWidth: screenMaxWidth ?? _screenMaxWidth,
          screenMaxHeight: screenMaxHeight ?? _screenMaxHeight,
          canvasColor: canvasColor ?? _canvasColor,
          cardColor: cardColor ?? _cardColor,
          displayLarge: displayLarge ?? _displayLarge,
          displayMedium: displayMedium ?? _displayMedium,
          displaySmall: displaySmall ?? _displaySmall,
          headlineLarge: headlineLarge ?? _headlineLarge,
          headlineMedium: headlineMedium ?? _headlineMedium,
          headlineSmall: headlineSmall ?? _headlineSmall,
          titleLarge: titleLarge ?? _titleLarge,
          titleMedium: titleMedium ?? _titleMedium,
          titleSmall: titleSmall ?? _titleSmall,
          labelLarge: labelLarge ?? _labelLarge,
          labelMedium: labelMedium ?? _labelMedium,
          labelSmall: labelSmall ?? _labelSmall,
          bodyLarge: bodyLarge ?? _bodyLarge,
          bodyMedium: bodyMedium ?? _bodyMedium,
          bodySmall: bodySmall ?? _bodySmall,
          actionRailButtonStates: actionRailButtonStates ?? _actionRailButtonStates,
          nodes: nodes ?? _nodes,
          nodeCardStates: nodeCardStates ?? _nodeCardStates,
          nodeCardCrossAxisCount: nodeCardCrossAxisCount ?? _nodeCardCrossAxisCount);

  @override
  List<Object> get props => [_UIStateVersion];
}

final class ActionRailButtonState extends Equatable {
  const ActionRailButtonState({RegionState? regionState, ButtonState? buttonState, Color? backgroundColor, Color? iconColor, double? iconOpacity, TextStyle? textStyle})
      : _regionState = regionState ?? RegionState.outRegion,
        _buttonState = buttonState ?? ButtonState.unselected,
        _backgroundColor = backgroundColor ?? const Color.fromRGBO(48, 52, 63, 1.0),
        _iconColor = iconColor ?? Colors.white,
        _iconOpacity = iconOpacity ?? 1.0,
        _textStyle = textStyle ?? const TextStyle();

  final RegionState _regionState;
  final ButtonState _buttonState;
  final Color _backgroundColor;
  Color get backgroundColor => _backgroundColor;
  final Color _iconColor;
  Color get iconColor => _iconColor;
  final double _iconOpacity;
  double get iconOpacity => _iconOpacity;
  final TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;

  static ActionRailButtonState defaultState(TextStyle textStyle) => ActionRailButtonState(textStyle: textStyle);

  ActionRailButtonState copyWith({RegionState? regionState, ButtonState? buttonState, Color? backgroundColor, Color? iconColor, double? iconOpacity, TextStyle? textStyle}) =>
      ActionRailButtonState(regionState: regionState ?? _regionState, buttonState: buttonState ?? _buttonState, backgroundColor: backgroundColor ?? _backgroundColor, iconColor: iconColor ?? _iconColor, iconOpacity: iconOpacity ?? _iconOpacity, textStyle: textStyle ?? _textStyle);

  @override
  List<Object> get props => [_backgroundColor, _iconColor, _iconOpacity, _textStyle];
}

final class NodeCardState extends Equatable {
  const NodeCardState({RegionState? regionState, ButtonState? buttonState, Color? backgroundColor, TextStyle? textStyle})
      : _regionState = regionState ?? RegionState.outRegion,
        _buttonState = buttonState ?? ButtonState.unselected,
        _backgroundColor = backgroundColor ?? Colors.transparent,
        _textStyle = textStyle ?? const TextStyle();

  final RegionState _regionState;
  final ButtonState _buttonState;
  final Color _backgroundColor;
  Color get backgroundColor => _backgroundColor;
  final TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;

  static NodeCardState defaultState(WorkerType type, TextStyle textStyle) => NodeCardState(
      regionState: RegionState.outRegion,
      buttonState: ButtonState.unselected,
      backgroundColor: type == WorkerType.COMBINATION
          ? const Color.fromRGBO(247, 206, 91, 1.0)
          : type == WorkerType.PERMUTATION
              ? const Color.fromRGBO(219, 48, 105, 1.0)
              : type == WorkerType.DECRYPTION
                  ? const Color.fromRGBO(124, 222, 220, 1.0)
                  : Colors.transparent,
      textStyle: textStyle);

  NodeCardState copyWith({RegionState? regionState, ButtonState? buttonState, Color? backgroundColor, TextStyle? textStyle}) =>
      NodeCardState(regionState: regionState ?? _regionState, buttonState: buttonState ?? _buttonState, backgroundColor: backgroundColor ?? _backgroundColor, textStyle: textStyle ?? _textStyle);

  @override
  List<Object> get props => [_backgroundColor, _textStyle];
}

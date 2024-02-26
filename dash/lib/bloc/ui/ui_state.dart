// ignore_for_file: non_constant_identifier_names, prefer_collection_literals

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

const TextStyle __displayLarge = TextStyle(fontWeight: FontWeight.bold, color: __textColor);
const TextStyle __displayMedium = TextStyle(fontWeight: FontWeight.bold, color: __textColor);
const TextStyle __displaySmall = TextStyle(fontWeight: FontWeight.bold, color: __textColor);
const TextStyle __headlineLarge = TextStyle(fontWeight: FontWeight.bold, color: __textColor);
const TextStyle __headlineMedium = TextStyle(fontWeight: FontWeight.bold, color: __textColor);
const TextStyle __headlineSmall = TextStyle(fontWeight: FontWeight.bold, color: __textColor);
const TextStyle __titleLarge = TextStyle(fontWeight: FontWeight.normal, color: __textColor);
const TextStyle __titleMedium = TextStyle(fontWeight: FontWeight.normal, color: __textColor);
const TextStyle __titleSmall = TextStyle(fontWeight: FontWeight.normal, color: __textColor);
const TextStyle __labelLarge = TextStyle(fontWeight: FontWeight.normal, color: __textColor, fontFamily: 'BebasNeue');
const TextStyle __labelMedium = TextStyle(fontWeight: FontWeight.normal, color: __textColor, fontFamily: 'BebasNeue');
const TextStyle __labelSmall = TextStyle(fontWeight: FontWeight.normal, color: __textColor, fontFamily: 'BebasNeue');
const TextStyle __bodyLarge = TextStyle(fontWeight: FontWeight.normal, color: __textColor, fontFamily: 'Montserrat');
const TextStyle __bodyMedium = TextStyle(fontWeight: FontWeight.normal, color: __textColor, fontFamily: 'Montserrat');
const TextStyle __bodySmall = TextStyle(fontWeight: FontWeight.normal, color: __textColor, fontFamily: 'Montserrat');

const Color __canvasColor = Color.fromRGBO(21, 22, 27, 1.0);
const Color __cardColor = Color.fromRGBO(48, 52, 63, 1.0);
const Color __cardHoverColor = Color.fromRGBO(100, 200, 180, 1.0);
const Color __textColor = Color.fromRGBO(255, 255, 255, 1.0);

const Color __combWorkerColor = Color.fromRGBO(247, 206, 91, 1.0);
const Color __permWorkerColor = Color.fromRGBO(219, 48, 105, 1.0);
const Color __decrWorkerColor = Color.fromRGBO(124, 222, 220, 1.0);

const Color __percentageBarStartColor = __decrWorkerColor;
const Color __percentageBarMidColor = __combWorkerColor;
const Color __percentageBarEndColor = __permWorkerColor;

enum ButtonState { unselected, thinking, selected }

enum ActionRailButtons { start, stop, log, settings }

final class UIState extends Equatable {
  UIState({
    int? UIStateVersion,
    double? screenMaxWidth,
    double? screenMaxHeight,
    UIThemeData? themeData,
    LinkedHashMap<ActionRailButtons, ActionRailButtonState>? actionRailButtonStates,
    NodePanelHeaderState? nodePanelHeaderState,
    List<Worker>? nodes,
    HashMap<String, NodeCardState>? nodeCardStates,
    int? nodeCardCrossAxisCount,
  })  : _UIStateVersion = UIStateVersion ?? 0,
        _screenMaxWidth = screenMaxWidth ?? 800,
        _screenMaxHeight = screenMaxHeight ?? 600,
        _themeData = themeData ?? const UIThemeData(),
        _actionRailButtonStates = actionRailButtonStates ??
            LinkedHashMap.fromIterable(
              ActionRailButtons.values,
              key: (button) => button,
              value: (button) => ActionRailButtonState.defaultState(__labelMedium),
            ),
        _nodePanelHeaderState = nodePanelHeaderState ?? NodePanelHeaderState(themeData: themeData ?? const UIThemeData()),
        _nodes = nodes ?? <Worker>[],
        _nodeCardStates = nodeCardStates ?? HashMap<String, NodeCardState>(),
        _nodeCardCrossAxisCount = nodeCardCrossAxisCount ?? 4;

  final int _UIStateVersion;
  int get UIStateVersion => _UIStateVersion;
  final double _screenMaxWidth;
  double get screenMaxWidth => _screenMaxWidth;
  final double _screenMaxHeight;
  double get screenMaxHeight => _screenMaxHeight;
  final UIThemeData _themeData;
  UIThemeData get themeData => _themeData;

  final LinkedHashMap<ActionRailButtons, ActionRailButtonState> _actionRailButtonStates;
  LinkedHashMap<ActionRailButtons, ActionRailButtonState> get actionRailButtonStates => LinkedHashMap.from(_actionRailButtonStates);

  final NodePanelHeaderState _nodePanelHeaderState;
  NodePanelHeaderState get nodePanelHeaderState => _nodePanelHeaderState;

  final List<Worker> _nodes;
  List<Worker> get nodes => List<Worker>.from(_nodes);

  final HashMap<String, NodeCardState> _nodeCardStates;
  HashMap<String, NodeCardState> get nodeCardStates => HashMap.from(_nodeCardStates);

  final int _nodeCardCrossAxisCount;
  int get nodeCardCrossAxisCount => _nodeCardCrossAxisCount;

  UIState copyWith({
    int? UIStateVersion,
    double? screenMaxWidth,
    double? screenMaxHeight,
    UIThemeData? themeData,
    LinkedHashMap<ActionRailButtons, ActionRailButtonState>? actionRailButtonStates,
    NodePanelHeaderState? nodePanelHeaderState,
    List<Worker>? nodes,
    HashMap<String, NodeCardState>? nodeCardStates,
    int? nodeCardCrossAxisCount,
  }) =>
      UIState(
          UIStateVersion: UIStateVersion ?? _UIStateVersion + 1,
          screenMaxWidth: screenMaxWidth ?? _screenMaxWidth,
          screenMaxHeight: screenMaxHeight ?? _screenMaxHeight,
          themeData: themeData ?? _themeData,
          actionRailButtonStates: actionRailButtonStates ?? _actionRailButtonStates,
          nodePanelHeaderState: nodePanelHeaderState ?? _nodePanelHeaderState,
          nodes: nodes ?? _nodes,
          nodeCardStates: nodeCardStates ?? _nodeCardStates,
          nodeCardCrossAxisCount: nodeCardCrossAxisCount ?? _nodeCardCrossAxisCount);

  @override
  List<Object> get props => [_UIStateVersion];
}

final class UIThemeData extends Equatable {
  const UIThemeData(
      {Color? canvasColor,
      Color? cardColor,
      Color? combColor,
      Color? permColor,
      Color? decrColor,
      Color? percentageBarStartColor,
      Color? percentageBarMidColor,
      Color? percentageBarEndColor,
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
      TextStyle? bodySmall})
      : _canvasColor = canvasColor ?? __canvasColor,
        _cardColor = cardColor ?? __cardColor,
        _combColor = combColor ?? __combWorkerColor,
        _permColor = permColor ?? __permWorkerColor,
        _decrColor = decrColor ?? __decrWorkerColor,
        _percentageBarStartColor = percentageBarStartColor ?? __percentageBarStartColor,
        _percentageBarMidColor = percentageBarMidColor ?? __percentageBarMidColor,
        _percentageBarEndColor = percentageBarEndColor ?? __percentageBarEndColor,
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
        _bodySmall = bodySmall ?? __bodySmall;

  final Color _canvasColor;
  Color get canvasColor => _canvasColor;
  final Color _cardColor;
  Color get cardColor => _cardColor;
  final Color _combColor;
  Color get combColor => _combColor;
  final Color _permColor;
  Color get permColor => _permColor;
  final Color _decrColor;
  Color get decrColor => _decrColor;
  final Color _percentageBarStartColor;
  Color get percentageBarStartColor => _percentageBarStartColor;
  final Color _percentageBarMidColor;
  Color get percentageBarMidColor => _percentageBarMidColor;
  final Color _percentageBarEndColor;
  Color get percentageBarEndColor => _percentageBarEndColor;
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

  UIThemeData copyWith(
          {Color? canvasColor,
          Color? cardColor,
          Color? combColor,
          Color? permColor,
          Color? decrColor,
          Color? percentageBarStartColor,
          Color? percentageBarMidColor,
          Color? percentageBarEndColor,
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
          TextStyle? bodySmall}) =>
      UIThemeData(
          canvasColor: canvasColor ?? _canvasColor,
          cardColor: cardColor ?? _cardColor,
          combColor: combColor ?? _combColor,
          permColor: permColor ?? _permColor,
          decrColor: decrColor ?? _decrColor,
          percentageBarStartColor: percentageBarStartColor ?? _percentageBarStartColor,
          percentageBarMidColor: percentageBarMidColor ?? _percentageBarMidColor,
          percentageBarEndColor: percentageBarEndColor ?? _percentageBarEndColor,
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
          bodySmall: bodySmall ?? _bodySmall);

  @override
  List<Object> get props => [
        _canvasColor,
        _cardColor,
        _combColor,
        _permColor,
        _decrColor,
        _percentageBarStartColor,
        _percentageBarMidColor,
        _percentageBarEndColor,
        _displayLarge,
        _displayMedium,
        _displaySmall,
        _headlineLarge,
        _headlineMedium,
        _headlineSmall,
        _titleLarge,
        _titleMedium,
        _titleSmall,
        _labelLarge,
        _labelMedium,
        _labelSmall,
        _bodyLarge,
        _bodyMedium,
        _bodySmall
      ];
}

final class ActionRailButtonState extends Equatable {
  const ActionRailButtonState({ButtonState? buttonState, Color? backgroundColor, Color? iconColor, double? iconOpacity, TextStyle? textStyle})
      : _buttonState = buttonState ?? ButtonState.unselected,
        _backgroundColor = backgroundColor ?? __cardColor,
        _iconColor = iconColor ?? Colors.white,
        _iconOpacity = iconOpacity ?? 1.0,
        _textStyle = textStyle ?? __labelMedium;

  final ButtonState _buttonState;
  ButtonState get buttonState => _buttonState;
  final Color _backgroundColor;
  Color get backgroundColor => _backgroundColor;
  final Color _iconColor;
  Color get iconColor => _iconColor;
  final double _iconOpacity;
  double get iconOpacity => _iconOpacity;
  final TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;

  static ActionRailButtonState defaultState(TextStyle textStyle) => ActionRailButtonState(textStyle: textStyle);

  ActionRailButtonState copyWith({ButtonState? buttonState, Color? backgroundColor, Color? iconColor, double? iconOpacity, TextStyle? textStyle}) =>
      ActionRailButtonState(buttonState: buttonState ?? _buttonState, backgroundColor: backgroundColor ?? _backgroundColor, iconColor: iconColor ?? _iconColor, iconOpacity: iconOpacity ?? _iconOpacity, textStyle: textStyle ?? _textStyle);

  @override
  List<Object> get props => [_backgroundColor, _iconColor, _iconOpacity, _textStyle];
}

abstract class NodePanelHeaderBtnBase {}

final class NodePanelHeaderSelectableBtn implements NodePanelHeaderBtnBase {
  const NodePanelHeaderSelectableBtn._(this.index);

  final int index;

  static const combination = NodePanelHeaderSelectableBtn._(0);
  static const permutation = NodePanelHeaderSelectableBtn._(1);
  static const decryption = NodePanelHeaderSelectableBtn._(2);
}

final class NodePanelHeaderDraggableBtn implements NodePanelHeaderBtnBase {
  const NodePanelHeaderDraggableBtn._(this.index);

  final int index;

  static const cpu = NodePanelHeaderDraggableBtn._(0);
  static const mem = NodePanelHeaderDraggableBtn._(1);
  static const ops = NodePanelHeaderDraggableBtn._(2);
  static const uptime = NodePanelHeaderDraggableBtn._(3);
}

class NodePanelHeaderPlaceholderBtn implements NodePanelHeaderBtnBase {
  const NodePanelHeaderPlaceholderBtn._(this.index);

  final int index;

  static const active1 = NodePanelHeaderPlaceholderBtn._(0);
  static const active2 = NodePanelHeaderPlaceholderBtn._(1);
  static const active3 = NodePanelHeaderPlaceholderBtn._(2);
  static const active4 = NodePanelHeaderPlaceholderBtn._(3);

  static const inactive1 = NodePanelHeaderPlaceholderBtn._(4);
  static const inactive2 = NodePanelHeaderPlaceholderBtn._(5);
  static const inactive3 = NodePanelHeaderPlaceholderBtn._(6);
  static const inactive4 = NodePanelHeaderPlaceholderBtn._(7);

  static NodePanelHeaderPlaceholderBtn activeByIndex(int index) {
    switch (index) {
      case 0:
        return active1;
      case 1:
        return active2;
      case 2:
        return active3;
      case 3:
        return active4;
      default:
        return NodePanelHeaderPlaceholderBtn._(index);
    }
  }

  static NodePanelHeaderPlaceholderBtn inactiveByIndex(int index) {
    switch (index) {
      case 0:
        return inactive1;
      case 1:
        return inactive2;
      case 2:
        return inactive3;
      case 3:
        return inactive4;
      default:
        return NodePanelHeaderPlaceholderBtn._(index);
    }
  }
}

final class NodePanelHeaderBtnState extends Equatable {
  const NodePanelHeaderBtnState({
    required String label,
    required TextStyle textStyle,
    required Color backgroundColor,
    required Color iconActiveColor,
    required Color iconInactiveColor,
    required bool isAscending,
  })  : _label = label,
        _textStyle = textStyle,
        _backgroundColor = backgroundColor,
        _iconActiveColor = iconActiveColor,
        _iconInactiveColor = iconInactiveColor,
        _isAscending = isAscending;

  final String _label;
  String get label => _label;
  final TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;
  final Color _backgroundColor;
  Color get backgroundColor => _backgroundColor;
  final Color _iconActiveColor;
  Color get iconActiveColor => _iconActiveColor;
  final Color _iconInactiveColor;
  Color get iconInactiveColor => _iconInactiveColor;
  final bool _isAscending;
  bool get isAscending => _isAscending;

  NodePanelHeaderBtnState copyWith({
    String? label,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? iconActiveColor,
    Color? iconInactiveColor,
    bool? isAscending,
  }) =>
      NodePanelHeaderBtnState(
        label: label ?? _label,
        textStyle: textStyle ?? _textStyle,
        backgroundColor: backgroundColor ?? _backgroundColor,
        iconActiveColor: iconActiveColor ?? _iconActiveColor,
        iconInactiveColor: iconInactiveColor ?? _iconInactiveColor,
        isAscending: isAscending ?? _isAscending,
      );

  @override
  List<Object?> get props => [
        _label,
        _textStyle,
        _backgroundColor,
        _iconActiveColor,
        _iconInactiveColor,
        _isAscending,
      ];
}

final class NodePanelHeaderState extends Equatable {
  NodePanelHeaderState({
    required UIThemeData themeData,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? selectableButtons,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? activeButtons,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? inactiveButtons,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? placeholderButtons,
  })  : _selectableButtons = selectableButtons ??
            LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>.from({
              NodePanelHeaderSelectableBtn.combination: NodePanelHeaderBtnState(
                label: 'COMB',
                backgroundColor: themeData.combColor,
                textStyle: themeData.labelMedium,
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderSelectableBtn.permutation: NodePanelHeaderBtnState(
                label: 'PERM',
                backgroundColor: themeData.permColor,
                textStyle: themeData.labelMedium,
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderSelectableBtn.decryption: NodePanelHeaderBtnState(
                label: 'DECR',
                backgroundColor: themeData.decrColor,
                textStyle: themeData.labelMedium,
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
            }),
        _activeButtons = activeButtons ??
            LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>.from({
              NodePanelHeaderDraggableBtn.cpu: NodePanelHeaderBtnState(
                label: 'CPU',
                backgroundColor: themeData.cardColor,
                textStyle: themeData.labelMedium,
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
            }),
        _inactiveButtons = inactiveButtons ??
            LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>.from({
              NodePanelHeaderDraggableBtn.mem: NodePanelHeaderBtnState(
                label: 'MEM',
                backgroundColor: themeData.cardColor,
                textStyle: themeData.labelMedium,
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderDraggableBtn.ops: NodePanelHeaderBtnState(
                label: 'OPS',
                backgroundColor: themeData.cardColor,
                textStyle: themeData.labelMedium,
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderDraggableBtn.uptime: NodePanelHeaderBtnState(
                label: 'UPT',
                backgroundColor: themeData.cardColor,
                textStyle: themeData.labelMedium,
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
            }),
        _placeholderButtons = placeholderButtons ??
            LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>.from({
              NodePanelHeaderPlaceholderBtn.active1: NodePanelHeaderBtnState(
                label: '1',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderPlaceholderBtn.active2: NodePanelHeaderBtnState(
                label: '2',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderPlaceholderBtn.active3: NodePanelHeaderBtnState(
                label: '3',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderPlaceholderBtn.active4: NodePanelHeaderBtnState(
                label: '4',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderPlaceholderBtn.inactive1: NodePanelHeaderBtnState(
                label: 'X',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderPlaceholderBtn.inactive2: NodePanelHeaderBtnState(
                label: 'X',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderPlaceholderBtn.inactive3: NodePanelHeaderBtnState(
                label: 'X',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
              NodePanelHeaderPlaceholderBtn.inactive4: NodePanelHeaderBtnState(
                label: 'X',
                backgroundColor: themeData.cardColor.withOpacity(0.5),
                textStyle: themeData.labelMedium.copyWith(color: themeData.labelMedium.color?.withOpacity(0.5)),
                iconActiveColor: Colors.white,
                iconInactiveColor: Colors.black.withOpacity(0.5),
                isAscending: false,
              ),
            });

  final LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> _selectableButtons;
  LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> get selectableButtons => LinkedHashMap.from(_selectableButtons);
  final LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> _activeButtons;
  LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> get activeButtons => LinkedHashMap.from(_activeButtons);
  final LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> _inactiveButtons;
  LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> get inactiveButtons => LinkedHashMap.from(_inactiveButtons);
  final LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> _placeholderButtons;
  LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState> get placeholderButtons => LinkedHashMap.from(_placeholderButtons);

  NodePanelHeaderState copyWith({
    required UIThemeData themeData,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? selectableButtons,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? activeButtons,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? inactiveButtons,
    LinkedHashMap<NodePanelHeaderBtnBase, NodePanelHeaderBtnState>? placeholderButtons,
  }) =>
      NodePanelHeaderState(
        themeData: themeData,
        selectableButtons: selectableButtons ?? _selectableButtons,
        activeButtons: activeButtons ?? _activeButtons,
        inactiveButtons: inactiveButtons ?? _inactiveButtons,
        placeholderButtons: placeholderButtons ?? _placeholderButtons,
      );

  @override
  List<Object> get props => [_selectableButtons, _activeButtons, _inactiveButtons, _placeholderButtons];
}

final class NodeCardState extends Equatable {
  const NodeCardState({
    ButtonState? buttonState,
    Color? typeColor,
    TextStyle? bodyTextStyle,
    TextStyle? labelTextStyle,
    Color? idCopyPaintColor,
    double? idCopyPaintOpacity,
    Color? ipCopyPaintColor,
    double? ipCopyPaintOpacity,
  })  : _buttonState = buttonState ?? ButtonState.unselected,
        _typeColor = typeColor ?? Colors.transparent,
        _bodyTextStyle = bodyTextStyle ?? __bodySmall,
        _labelTextStyle = labelTextStyle ?? __labelMedium,
        _idCopyPaintColor = idCopyPaintColor ?? Colors.transparent,
        _idCopyPaintOpacity = idCopyPaintOpacity ?? 0.0,
        _ipCopyPaintColor = ipCopyPaintColor ?? Colors.transparent,
        _ipCopyPaintOpacity = ipCopyPaintOpacity ?? 0.0;

  final ButtonState _buttonState;
  ButtonState get buttonState => _buttonState;
  final Color _typeColor;
  Color get typeColor => _typeColor;
  final TextStyle _bodyTextStyle;
  TextStyle get bodyTextStyle => _bodyTextStyle;
  final TextStyle _labelTextStyle;
  TextStyle get labelTextStyle => _labelTextStyle;
  final Color _idCopyPaintColor;
  Color get idCopyPaintColor => _idCopyPaintColor;
  final double _idCopyPaintOpacity;
  double get idCopyPaintOpacity => _idCopyPaintOpacity;
  final Color _ipCopyPaintColor;
  Color get ipCopyPaintColor => _ipCopyPaintColor;
  final double _ipCopyPaintOpacity;
  double get ipCopyPaintOpacity => _ipCopyPaintOpacity;

  static NodeCardState defaultState({required WorkerType type, required TextStyle bodyTextStyle, required TextStyle labelTextStyle}) {
    final Color typeColor = type == WorkerType.COMBINATION
        ? __combWorkerColor
        : type == WorkerType.PERMUTATION
            ? __permWorkerColor
            : type == WorkerType.DECRYPTION
                ? __decrWorkerColor
                : Colors.transparent;
    return NodeCardState(
      buttonState: ButtonState.unselected,
      typeColor: typeColor,
      bodyTextStyle: bodyTextStyle,
      labelTextStyle: labelTextStyle,
      idCopyPaintColor: typeColor,
      idCopyPaintOpacity: 0.25,
      ipCopyPaintColor: typeColor,
      ipCopyPaintOpacity: 0.25,
    );
  }

  NodeCardState copyWith({
    ButtonState? buttonState,
    Color? typeColor,
    TextStyle? bodyTextStyle,
    TextStyle? labelTextStyle,
    Color? idCopyPaintColor,
    double? idCopyPaintOpacity,
    Color? ipCopyPaintColor,
    double? ipCopyPaintOpacity,
  }) =>
      NodeCardState(
        buttonState: buttonState ?? _buttonState,
        typeColor: typeColor ?? _typeColor,
        bodyTextStyle: bodyTextStyle ?? _bodyTextStyle,
        labelTextStyle: labelTextStyle ?? _labelTextStyle,
        idCopyPaintColor: idCopyPaintColor ?? _idCopyPaintColor,
        idCopyPaintOpacity: idCopyPaintOpacity ?? _idCopyPaintOpacity,
        ipCopyPaintColor: ipCopyPaintColor ?? _ipCopyPaintColor,
        ipCopyPaintOpacity: ipCopyPaintOpacity ?? _ipCopyPaintOpacity,
      );

  @override
  List<Object> get props => [_typeColor, _bodyTextStyle, _labelTextStyle, _idCopyPaintColor, _idCopyPaintOpacity, _ipCopyPaintColor, _ipCopyPaintOpacity];
}

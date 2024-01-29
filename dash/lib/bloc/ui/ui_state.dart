// ignore_for_file: non_constant_identifier_names

part of 'ui_amal.dart';

enum ARBState { unselected, loading, selected }

final class UIState extends Equatable {
  const UIState({
    this.ARBStart = ARBState.unselected,
    this.ARBStartButtonStyle = const ButtonStyle(),
    this.ARBStartTextStyle = const TextStyle(),
    this.ARBStop = ARBState.unselected,
    this.ARBStopButtonStyle = const ButtonStyle(),
    this.ARBStopTextStyle = const TextStyle(),
    this.ARBLog = ARBState.unselected,
    this.ARBLogButtonStyle = const ButtonStyle(),
    this.ARBLogTextStyle = const TextStyle(),
    this.ARBSettings = ARBState.unselected,
    this.ARBSettingsButtonStyle = const ButtonStyle(),
    this.ARBSettingsTextStyle = const TextStyle()
  });

  final ARBState ARBStart;
  final ButtonStyle ARBStartButtonStyle;
  final TextStyle ARBStartTextStyle;
  final ARBState ARBStop;
  final ButtonStyle ARBStopButtonStyle;
  final TextStyle ARBStopTextStyle;
  final ARBState ARBLog;
  final ButtonStyle ARBLogButtonStyle;
  final TextStyle ARBLogTextStyle;
  final ARBState ARBSettings;
  final ButtonStyle ARBSettingsButtonStyle;
  final TextStyle ARBSettingsTextStyle;

  UIState copyWith({
    ARBState? ARBStart,
    ButtonStyle? ARBStartButtonStyle,
    TextStyle? ARBStartTextStyle,
    ARBState? ARBStop,
    ButtonStyle? ARBStopButtonStyle,
    TextStyle? ARBStopTextStyle,
    ARBState? ARBLog,
    ButtonStyle? ARBLogButtonStyle,
    TextStyle? ARBLogTextStyle,
    ARBState? ARBSettings,
    ButtonStyle? ARBSettingsButtonStyle,
    TextStyle? ARBSettingsTextStyle
  }) => UIState(
    ARBStart: ARBStart ?? this.ARBStart,
    ARBStartButtonStyle: ARBStartButtonStyle ?? this.ARBStartButtonStyle,
    ARBStartTextStyle: ARBStartTextStyle ?? this.ARBStartTextStyle,
    ARBStop: ARBStop ?? this.ARBStop,
    ARBStopButtonStyle: ARBStopButtonStyle ?? this.ARBStopButtonStyle,
    ARBStopTextStyle: ARBStopTextStyle ?? this.ARBStopTextStyle,
    ARBLog: ARBLog ?? this.ARBLog,
    ARBLogButtonStyle: ARBLogButtonStyle ?? this.ARBLogButtonStyle,
    ARBLogTextStyle: ARBLogTextStyle ?? this.ARBLogTextStyle,
    ARBSettings: ARBSettings ?? this.ARBSettings,
    ARBSettingsButtonStyle: ARBSettingsButtonStyle ?? this.ARBSettingsButtonStyle,
    ARBSettingsTextStyle: ARBSettingsTextStyle ?? this.ARBSettingsTextStyle,
  );

  @override
  List<Object> get props => [
    ARBStart,
    ARBStartButtonStyle,
    ARBStartTextStyle,
    ARBStop,
    ARBStopButtonStyle,
    ARBStopTextStyle,
    ARBLog,
    ARBLogButtonStyle,
    ARBLogTextStyle,
    ARBSettings,
    ARBSettingsButtonStyle,
    ARBSettingsTextStyle
  ];
}

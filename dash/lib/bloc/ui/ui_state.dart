// ignore_for_file: non_constant_identifier_names

part of 'ui_bloc.dart';

final class UIState extends Equatable {
  const UIState({
    this.ARBStart = false,
    this.ARBStartButtonStyle = const ButtonStyle(),
    this.ARBStartTextStyle = const TextStyle(),
    this.ARBStop = false,
    this.ARBStopButtonStyle = const ButtonStyle(),
    this.ARBStopTextStyle = const TextStyle(),
    this.ARBLog = false,
    this.ARBLogButtonStyle = const ButtonStyle(),
    this.ARBLogTextStyle = const TextStyle(),
    this.ARBSettings = false,
    this.ARBSettingsButtonStyle = const ButtonStyle(),
    this.ARBSettingsTextStyle = const TextStyle()
  });

  final bool ARBStart;
  final ButtonStyle ARBStartButtonStyle;
  final TextStyle ARBStartTextStyle;
  final bool ARBStop;
  final ButtonStyle ARBStopButtonStyle;
  final TextStyle ARBStopTextStyle;
  final bool ARBLog;
  final ButtonStyle ARBLogButtonStyle;
  final TextStyle ARBLogTextStyle;
  final bool ARBSettings;
  final ButtonStyle ARBSettingsButtonStyle;
  final TextStyle ARBSettingsTextStyle;

  UIState copyWith({
    bool? ARBStart,
    ButtonStyle? ARBStartButtonStyle,
    TextStyle? ARBStartTextStyle,
    bool? ARBStop,
    ButtonStyle? ARBStopButtonStyle,
    TextStyle? ARBStopTextStyle,
    bool? ARBLog,
    ButtonStyle? ARBLogButtonStyle,
    TextStyle? ARBLogTextStyle,
    bool? ARBSettings,
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

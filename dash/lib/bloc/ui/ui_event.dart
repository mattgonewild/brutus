part of 'ui_bloc.dart';

sealed class UIEvent extends Equatable {
  const UIEvent();

  @override
  List<Object> get props => [];
}

final class ARBStartPressed extends UIEvent {
  const ARBStartPressed();
}

final class ARBStartOn extends UIEvent {
  const ARBStartOn();
}

final class ARBStartOff extends UIEvent {
  const ARBStartOff();
}

final class ARBStopPressed extends UIEvent {
  const ARBStopPressed();
}

final class ARBStopOn extends UIEvent {
  const ARBStopOn();
}

final class ARBStopOff extends UIEvent {
  const ARBStopOff();
}

final class ARBLogPressed extends UIEvent {
  const ARBLogPressed();
}

final class ARBLogOn extends UIEvent {
  const ARBLogOn();
}

final class ARBLogOff extends UIEvent {
  const ARBLogOff();
}

final class ARBSettingsPressed extends UIEvent {
  const ARBSettingsPressed();
}

final class ARBSettingsOn extends UIEvent {
  const ARBSettingsOn();
}

final class ARBSettingsOff extends UIEvent {
  const ARBSettingsOff();
}

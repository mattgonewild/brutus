part of 'ui_bloc.dart';

sealed class UIEvent extends Equatable {
  const UIEvent();

  @override
  List<Object> get props => [];
}

final class ARBStartPressed extends UIEvent {
  const ARBStartPressed();
}

final class ARBStopPressed extends UIEvent {
  const ARBStopPressed();
}

final class ARBLogPressed extends UIEvent {
  const ARBLogPressed();
}

final class ARBSettingsPressed extends UIEvent {
  const ARBSettingsPressed();
}

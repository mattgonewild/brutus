part of 'ui_amal.dart';

sealed class UIEvent extends Equatable {
  const UIEvent();

  @override
  List<Object> get props => [];
}

final class NodeStateUpdated extends UIEvent {
  const NodeStateUpdated(this.nodeState);

  final NodeState nodeState;

  @override
  List<Object> get props => [nodeState];
}

final class LayoutConstraintsUpdated extends UIEvent {
  const LayoutConstraintsUpdated(this.maxWidth, this.maxHeight);

  final double maxWidth;
  final double maxHeight;

  @override
  List<Object> get props => [maxWidth, maxHeight];
}

final class ARBHovered extends UIEvent {
  const ARBHovered(this.button);

  final ActionRailButtons button;

  @override
  List<Object> get props => [button];
}

final class ARBUnhovered extends UIEvent {
  const ARBUnhovered(this.button);

  final ActionRailButtons button;

  @override
  List<Object> get props => [button];
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

final class NodePanelHeaderTargetOnWillAcceptWithDetails extends UIEvent {
  const NodePanelHeaderTargetOnWillAcceptWithDetails(this.index, this.btnState);

  final int index;
  final NodePanelHeaderBtnState btnState;

  @override
  List<Object> get props => [index, btnState];
}

final class NodePanelHeaderTargetOnAcceptWithDetails extends UIEvent {
  const NodePanelHeaderTargetOnAcceptWithDetails();

  @override
  List<Object> get props => [];
}

final class NodePanelHeaderTargetOnLeave extends UIEvent {
  const NodePanelHeaderTargetOnLeave();

  @override
  List<Object> get props => [];
}

final class NodeCardIDCopyHovered extends UIEvent {
  const NodeCardIDCopyHovered(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class NodeCardIDCopyUnhovered extends UIEvent {
  const NodeCardIDCopyUnhovered(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class NodeCardIPCopyHovered extends UIEvent {
  const NodeCardIPCopyHovered(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class NodeCardIPCopyUnhovered extends UIEvent {
  const NodeCardIPCopyUnhovered(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

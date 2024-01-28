part of 'node.dart';

sealed class NodeEvent extends Equatable {
  const NodeEvent();

  @override
  List<Object> get props => [];
}

final class NodeAdded extends NodeEvent {
  const NodeAdded();
}

final class NodeRemoved extends NodeEvent {
  const NodeRemoved();
}

final class NodeDestroyed extends NodeEvent {
  const NodeDestroyed();
}

final class NodeMetrics extends NodeEvent {
  const NodeMetrics();
}
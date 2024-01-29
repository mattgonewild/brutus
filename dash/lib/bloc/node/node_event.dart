part of 'node_amal.dart';

sealed class NodeEvent extends Equatable {
  const NodeEvent();

  @override
  List<Object> get props => [];
}

final class NodeAdded extends NodeEvent {
  const NodeAdded({required this.node});

  final Worker node;

  @override
  List<Object> get props => [node];
}

final class NodeRemoved extends NodeEvent {
  const NodeRemoved({required this.node});

  final Worker node;

  @override
  List<Object> get props => [node];
}

final class NodeDestroyed extends NodeEvent {
  const NodeDestroyed({required this.node});

  final Worker node;

  @override
  List<Object> get props => [node];
}

final class NodeMetrics extends NodeEvent {
  const NodeMetrics({required this.node});

  final Worker node;

  @override
  List<Object> get props => [node];
}
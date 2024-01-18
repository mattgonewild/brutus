part of 'node_bloc.dart';

final class NodeState extends Equatable {
  const NodeState({this.nodeCount = 0});

  final int nodeCount;

  @override
  List<Object> get props => [nodeCount];
}

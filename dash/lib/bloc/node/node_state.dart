part of 'node_bloc.dart';

const compareNodeTimestamp = _compareWorkerTimestamp;
int _compareWorkerTimestamp(Worker a, Worker b) => a.time.toDateTime().compareTo(b.time.toDateTime());

const compareNodeLoad5 = _compareWorkerLoad5;
int _compareWorkerLoad5(Worker a, Worker b) => a.proc.loadAvg.fiveMinutes > b.proc.loadAvg.fiveMinutes ? 1 : -1;

final class NodeState extends Equatable {
  NodeState({
    this.nodeCount = 0,
    SplayTreeSet<Worker>? nodes,
    this.comparator = compareNodeTimestamp
  }) : nodes = nodes ?? SplayTreeSet<Worker>(comparator);

  final int nodeCount;
  final SplayTreeSet<Worker> nodes;
  final Comparator<Worker> comparator;

  NodeState copyWith({
    int? nodeCount, 
    SplayTreeSet<Worker>? nodes, 
    Comparator<Worker>? comparator
  }) {
    nodes ??= this.nodes;
    if (comparator != null && comparator != this.comparator) {
      nodes = SplayTreeSet<Worker>(comparator)..addAll(nodes);
    }
    return NodeState(
      nodeCount: nodeCount ?? this.nodeCount,
      nodes: nodes,
      comparator: comparator ?? this.comparator
    );
  }

  @override
  List<Object> get props => [nodeCount, nodes];
}

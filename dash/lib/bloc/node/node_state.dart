part of 'node_amal.dart';

const compareNodeTimestamp = _compareWorkerTimestamp;
int _compareWorkerTimestamp(Worker a, Worker b) => a.time.toDateTime().compareTo(b.time.toDateTime());

const compareNodeLoad5 = _compareWorkerLoad5;
int _compareWorkerLoad5(Worker a, Worker b) => a.proc.loadAvg.fiveMinutes > b.proc.loadAvg.fiveMinutes ? 1 : -1;

final class NodeState extends Equatable {
  NodeState({
    SplayTreeSet<Worker>? nodes,
    this.comparator = compareNodeTimestamp,
    HashMap<String, Worker>? ids,
    HashMap<String, Proc>? last,
  }) : nodes = nodes ?? SplayTreeSet<Worker>(comparator), ids = ids ?? HashMap<String, Worker>(), last = last ?? HashMap<String, Proc>();

  final SplayTreeSet<Worker> nodes;
  final Comparator<Worker> comparator;
  final HashMap<String, Worker> ids;
  final HashMap<String, Proc> last;

  NodeState addNode(Worker node) { ids[node.id] = node; return _copyWith(nodes: nodes..add(node)); }

  NodeState removeNode(String id) => _copyWith(nodes: nodes..remove(ids.remove(id))); // TODO: ...

  NodeState updateNode(Worker node) { removeNode(node.id); return addNode(node); } // TODO: ...

  NodeState updateComparator(Comparator<Worker> comparator) => _copyWith(comparator: comparator);

  NodeState _copyWith({
    SplayTreeSet<Worker>? nodes, 
    Comparator<Worker>? comparator,
  }) {
    if (nodes != null) {
      for (final Worker node in nodes) {
        last[node.id] = node.proc;
      }
    }
    nodes ??= this.nodes;
    if (comparator != null && comparator != this.comparator) {
      nodes = SplayTreeSet<Worker>(comparator)..addAll(nodes);
    }
    return NodeState(
      nodes: nodes,
      comparator: comparator ?? this.comparator,
      ids: ids,
      last: last,
    );
  }

  @override
  List<Object> get props => [nodes, last];
}

part of 'node_amal.dart';

const compareNodeType = _compareWorkerType;
int _compareWorkerType(Worker a, Worker b) {
  const after = 1;
  const before = -1;

  if (a.type == b.type) {
    return a.id.compareTo(b.id);
  }

  int weight(WorkerType type) {
    switch (type) {
      case WorkerType.COMBINATION:
        return 1;
      case WorkerType.PERMUTATION:
        return 2;
      case WorkerType.DECRYPTION:
        return 3;
      default:
        return 0;
    }
  }

  return weight(a.type) > weight(b.type) ? after : before;
}

const compareNodeTimestamp = _compareWorkerTimestamp;
int _compareWorkerTimestamp(Worker a, Worker b) => a.time.toDateTime().compareTo(b.time.toDateTime());

const compareNodeLoad5 = _compareWorkerLoad5;
int _compareWorkerLoad5(Worker a, Worker b) => a.proc.loadAvg.fiveMinutes > b.proc.loadAvg.fiveMinutes ? 1 : -1;

final class NodeState {
  NodeState({
    SplayTreeSet<Worker>? nodes,
    Comparator<Worker> comparator = compareNodeType,
    HashMap<String, Worker>? ids,
  })  : _comparator = comparator,
        _nodes = nodes ?? SplayTreeSet<Worker>(comparator),
        _ids = ids ?? HashMap<String, Worker>();

  final SplayTreeSet<Worker> _nodes;
  SplayTreeSet<Worker> get nodes => _nodes;

  final Comparator<Worker> _comparator;
  final HashMap<String, Worker> _ids;

  NodeState addNode(Worker node) {
    _ids[node.id] = node;
    return _copyWith(nodes: _nodes..add(node));
  }

  NodeState removeNode(String id) => _copyWith(nodes: _nodes..remove(_ids.remove(id))); // TODO: ...

  NodeState updateNode(Worker node) {
    removeNode(node.id);
    return addNode(node);
  } // TODO: ...

  NodeState updateComparator(Comparator<Worker> comparator) => _copyWith(comparator: comparator);

  NodeState _copyWith({
    SplayTreeSet<Worker>? nodes,
    Comparator<Worker>? comparator,
  }) {
    nodes ??= _nodes;
    if (comparator != null && comparator != _comparator) {
      nodes = SplayTreeSet<Worker>(comparator)..addAll(nodes);
    }
    return NodeState(
      nodes: nodes,
      comparator: comparator ?? _comparator,
      ids: _ids,
    );
  }
}

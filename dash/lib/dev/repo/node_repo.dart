import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:brutus/brutus.dart';
import 'package:fixnum/fixnum.dart';
import 'package:uuid/uuid.dart'; // do not add to pubspec.yaml dependencies

import '../bloc/node/node_amal.dart' show NodeEvent;
import '../bloc/node/node_amal.dart' show NodeAdded;
import '../bloc/node/node_amal.dart' show NodeRemoved;
import '../bloc/node/node_amal.dart' show NodeDestroyed;
import '../bloc/node/node_amal.dart' show NodeMetrics;

class NodeRepo {
  NodeRepo() {
    _receivePort.listen((data) {
      if (data is NodeEvent) {
        _streamController.add(data);
      } else if (data is Exception) {
        // ...
      }
    });

    Isolate.spawn(NodeRepoWorker.checkOnNodes, _receivePort.sendPort).then((isolate) => _nodeRepoWorker = isolate);
  }

  final StreamController<NodeEvent> _streamController = StreamController<NodeEvent>.broadcast();
  Stream<NodeEvent> get stream => _streamController.stream;

  final ReceivePort _receivePort = ReceivePort();
  late Isolate _nodeRepoWorker;

  void dispose() {
    _streamController.close();
    _receivePort.close();
    _nodeRepoWorker.kill(priority: Isolate.immediate);
  }
}

class NodeRepoWorker {
  static void checkOnNodes(SendPort sendPort) {
    try {
      while (true) {
        for (final node in _nodes.values) {
          node.ops = _randomOpsIncrement(node);
          _nodes[node.id] = node;
          sendPort.send(NodeMetrics(
              node: Worker(
            id: node.id,
            time: Timestamp.fromDateTime(DateTime.now()),
            ip: node.ip,
            type: node.type,
            proc: _randomProcData(node),
            ops: node.ops,
          )));
        }
        sendPort.send(_randomNodeEvent());
        sleep(const Duration(seconds: 1));
      }
    } catch (e) {
      if (e is Exception) {
        sendPort.send(e);
      } else {
        rethrow;
      }
    }
  }
}

final HashMap<String, Worker> _nodes = HashMap<String, Worker>();
final HashMap<int, int> _activeNodesByType = HashMap<int, int>();

NodeEvent _randomNodeEvent() {
  if (_nodes.length <= 5) return _addNode();

  switch (Random().nextInt(100) + 1) {
    case <= 80:
      return _updateNode();
    case <= 90:
      return _addNode();
    case <= 95:
      return _removeNode();
    default:
      return _destroyNode();
  }
}

String _randomIPv6() {
  final List<String> parts = List<String>.generate(8, (index) => Random().nextInt(65535).toRadixString(16));
  return parts.join(':');
}

WorkerType _randomWorkerType() {
  WorkerType? checkWorkerType(WorkerType type) {
    if (_activeNodesByType[type.value] == null || _activeNodesByType[type.value]! <= 0) {
      return type;
    }
    return null;
  }

  WorkerType? type = checkWorkerType(WorkerType.COMBINATION) ?? checkWorkerType(WorkerType.PERMUTATION) ?? checkWorkerType(WorkerType.DECRYPTION);

  if (type != null) return type;

  switch (Random().nextInt(100) + 1) {
    case <= 70:
      return WorkerType.DECRYPTION;
    case <= 90:
      return WorkerType.PERMUTATION;
    default:
      return WorkerType.COMBINATION;
  }
}

Proc _randomProcData(Worker? node) {
  return Proc(
      cpu: Cpu(
        total: Int64(100),
        idle: Int64(Random().nextInt(100)),
      ),
      mem: Mem(
        total: Int64(100),
        used: Int64(Random().nextInt(100)),
        swapTotal: Int64(100),
        swapUsed: Int64(Random().nextInt(100)),
      ),
      uptime: Uptime(
        duration: node == null ? Int64(0) : node.proc.uptime.duration + Int64(DateTime.now().difference(node.time.toDateTime()).inMilliseconds),
      ));
}

Int64 _randomOpsIncrement(Worker node) => node.ops + Int64(Random().nextInt(100));

NodeEvent _updateNode() {
  if (_nodes.isEmpty) return _addNode();
  final node = _nodes.values.elementAt(Random().nextInt(_nodes.length));
  _nodes[node.id]!.ops = _randomOpsIncrement(node);
  node.ops = _nodes[node.id]!.ops;
  return NodeMetrics(node: Worker(id: node.id, time: Timestamp.fromDateTime(DateTime.now()), ip: node.ip, type: node.type, proc: _randomProcData(node), ops: node.ops));
}

NodeEvent _addNode() {
  final type = _randomWorkerType();
  final node = Worker(id: const Uuid().v4(), time: Timestamp.fromDateTime(DateTime.now()), ip: _randomIPv6(), type: type, proc: _randomProcData(null), ops: Int64(0));
  _nodes[node.id] = node;
  _activeNodesByType[type.value] = (_activeNodesByType[type.value] ?? 0) + 1;
  return NodeAdded(node: node);
}

NodeEvent _removeNode() {
  if (_nodes.isEmpty) return _addNode();
  final node = _nodes.values.elementAt(Random().nextInt(_nodes.length));
  _nodes.remove(node.id);
  _activeNodesByType[node.type.value] = (_activeNodesByType[node.type.value] ?? 0) - 1;
  return NodeRemoved(node: node);
}

NodeEvent _destroyNode() {
  if (_nodes.isEmpty) return _addNode();
  final node = _nodes.values.elementAt(Random().nextInt(_nodes.length));
  _nodes.remove(node.id);
  _activeNodesByType[node.type.value] = (_activeNodesByType[node.type.value] ?? 0) - 1;
  return NodeDestroyed(node: node);
}

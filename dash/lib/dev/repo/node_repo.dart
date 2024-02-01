import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:brutus/brutus.dart';
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
        sendPort.send(_randomNodeEvent()); sleep(const Duration(seconds: 1));
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

NodeEvent _randomNodeEvent() {
  switch (Random().nextInt(100) + 1) {
    case <=50: return NodeMetrics(node: _updateNode());
    case <=75: return NodeAdded(node: _addNode());
    case <=90: return NodeRemoved(node: _removeNode());
    default: return NodeDestroyed(node: _destroyNode());
  }
}

Worker _updateNode() {
  if (_nodes.isEmpty) return _addNode();
  final node = _nodes.values.elementAt(Random().nextInt(_nodes.length));
  return node;
}

Worker _addNode() {
  final node = Worker(id: const Uuid().v4());
  _nodes[node.id] = node;
  return node;
}

Worker _removeNode() {
  if (_nodes.isEmpty) return _addNode();
  final node = _nodes.values.elementAt(Random().nextInt(_nodes.length));
  _nodes.remove(node.id);
  return node;
}

Worker _destroyNode() {
  return _removeNode();
}

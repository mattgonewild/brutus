part of 'node.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc({required NodeRepo nodeRepo})
      : _nodeRepo = nodeRepo,
        super(NodeState());

  final NodeRepo _nodeRepo;
}

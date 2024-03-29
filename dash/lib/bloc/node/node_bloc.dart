part of 'node_amal.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc({required NodeRepo nodeRepo}) : _nodeRepo = nodeRepo, super(NodeState()) {
    _nodeRepoSubscription = _nodeRepo.stream.listen((NodeEvent event) {
      add(event);
    });

    on<NodeAdded>(_onNodeAdded);
    on<NodeRemoved>(_onNodeRemoved);
    on<NodeDestroyed>(_onNodeDestroyed);
    on<NodeMetrics>(_onNodeMetrics);
  }

  final NodeRepo _nodeRepo;
  late StreamSubscription<NodeEvent> _nodeRepoSubscription;

  Future<void> _onNodeAdded(NodeAdded event, Emitter<NodeState> emit) async {
    emit(state.addNode(event.node));
  }

  Future<void> _onNodeRemoved(NodeRemoved event, Emitter<NodeState> emit) async {
    emit(state.removeNode(event.node.id));
  }

  Future<void> _onNodeDestroyed(NodeDestroyed event, Emitter<NodeState> emit) async {
    emit(state.removeNode(event.node.id));
  }

  Future<void> _onNodeMetrics(NodeMetrics event, Emitter<NodeState> emit) async {
    emit(state.updateNode(event.node));
  }

  @override
  Future<void> close() {
    _nodeRepoSubscription.cancel();
    _nodeRepo.dispose();
    return super.close();
  }
}

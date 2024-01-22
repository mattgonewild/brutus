import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:brutus/brutus.dart';
import 'package:dash/repo/node_repo.dart';
import 'package:equatable/equatable.dart';

part 'node_event.dart';
part 'node_state.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  NodeBloc({required NodeRepo nodeRepo})
      : _nodeRepo = nodeRepo,
        super(NodeState());

  final NodeRepo _nodeRepo;
}

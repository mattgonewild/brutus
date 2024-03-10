part of 'node_panel_amal.dart';

final class NodePanelState extends Equatable {
  const NodePanelState(
    this._opts,
    this._headerState,
    this._gridState,
  );

  final NodePanelOpts _opts;
  NodePanelOpts get opts => _opts.copyWith();

  final NodePanelHeaderState _headerState;
  NodePanelHeaderState get headerState => _headerState.copyWith();

  final NodePanelGridState _gridState;
  NodePanelGridState get gridState => _gridState.copyWith();

  NodePanelState copyWith({
    NodePanelOpts? opts,
    NodePanelHeaderState? headerState,
    NodePanelGridState? gridState,
  }) {
    return NodePanelState(
      opts ?? _opts,
      headerState ?? _headerState,
      gridState ?? _gridState,
    );
  }

  @override
  List<Object> get props => [
        _opts,
        _headerState,
        _gridState,
      ];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                         NodePanelOpts
///
///
///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

final class NodePanelOpts extends Equatable {
  const NodePanelOpts(
    this._includedTypesInOrder,
    this._sortOptsInOrder,
  );

  final List<WorkerType> _includedTypesInOrder;
  List<WorkerType> get includedTypesInOrder => List.from(_includedTypesInOrder);

  final List<SortOpts> _sortOptsInOrder;
  List<SortOpts> get sortOptsInOrder => List.from(_sortOptsInOrder);

  NodePanelOpts copyWith({
    List<WorkerType>? includedTypesInOrder,
    List<SortOpts>? sortOptsInOrder,
  }) {
    return NodePanelOpts(
      includedTypesInOrder ?? _includedTypesInOrder,
      sortOptsInOrder ?? _sortOptsInOrder,
    );
  }

  @override
  List<Object> get props => [
        _includedTypesInOrder,
        _sortOptsInOrder,
      ];
}

final class SortOpts extends Equatable {
  const SortOpts(
    this._field,
    this._direction,
  );

  final SortField _field;
  final SortDirection _direction;

  SortOpts copyWith({
    SortField? field,
    SortDirection? direction,
  }) {
    return SortOpts(
      field ?? _field,
      direction ?? _direction,
    );
  }

  @override
  List<Object> get props => [
        _field,
        _direction,
      ];
}

enum SortField { cpu, mem, ops, uptime }

enum SortDirection { asc, desc }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                         NodePanelHeaderState
///
///
///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

final class NodePanelHeaderState extends Equatable {
  const NodePanelHeaderState(
    this._btnStateTemp,
    this._childWhenDragging,
    this._btnStatePerm,
  );

  final List<NodePanelHeaderBtnState> _btnStateTemp;
  List<NodePanelHeaderBtnState> get btnStateTemp => List.from(_btnStateTemp);

  final List<NodePanelHeaderBtnState> _childWhenDragging;
  List<NodePanelHeaderBtnState> get childWhenDragging => List.from(_childWhenDragging);

  final List<NodePanelHeaderBtnState> _btnStatePerm;
  List<NodePanelHeaderBtnState> get btnStatePerm => List.from(_btnStatePerm);

  NodePanelHeaderState copyWith({
    List<NodePanelHeaderBtnState>? btnStateTemp,
    List<NodePanelHeaderBtnState>? childWhenDragging,
    List<NodePanelHeaderBtnState>? btnStatePerm,
  }) {
    return NodePanelHeaderState(
      btnStateTemp ?? _btnStateTemp,
      childWhenDragging ?? _childWhenDragging,
      btnStatePerm ?? _btnStatePerm,
    );
  }

  @override
  List<Object> get props => [
        _btnStateTemp,
        _childWhenDragging,
        _btnStatePerm,
      ];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                         NodePanelHeaderBtnState
///
///
///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

final class NodePanelHeaderBtnState extends Equatable {
  const NodePanelHeaderBtnState(
    this._label,
    this._style,
  );

  final String _label;
  String get label => _label;

  final TextStyle _style;
  TextStyle get style => _style;

  NodePanelHeaderBtnState copyWith({
    String? label,
    TextStyle? style,
  }) {
    return NodePanelHeaderBtnState(
      label ?? _label,
      style ?? _style,
    );
  }

  @override
  List<Object> get props => [
        _label,
        _style,
      ];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                         NodePanelGridState
///
///
///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

final class NodePanelGridState extends Equatable {
  const NodePanelGridState(
    this._numCols,
    this._items,
  );

  final int _numCols;
  int get numCols => _numCols;

  final List<NodePanelGridItemState> _items;
  List<Worker> get items => List.from(_items);

  NodePanelGridState copyWith({
    int? numCols,
    List<NodePanelGridItemState>? items,
  }) {
    return NodePanelGridState(
      numCols ?? _numCols,
      items ?? _items,
    );
  }

  @override
  List<Object> get props => [
        _numCols,
        _items,
      ];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                         NodePanelGridItemState
///
///
///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

final class NodePanelGridItemState extends Equatable {
  const NodePanelGridItemState();

  @override
  List<Object> get props => [];
}

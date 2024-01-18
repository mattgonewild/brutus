import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dash/bloc/sys/sys_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  UIBloc({required SysBloc sysBloc}) : _sysBloc = sysBloc, super(const UIState()) {
    _sysBlocSubscription = _sysBloc.stream.listen((SysState state) {
      switch (state) {
        case SysState.running: add(const ARBStartOn());
        case SysState.stopped: add(const ARBStartOff());
        case SysState.unknown: add(const ARBStartOff());
      }
    });
    
    on<ARBStartPressed>(_onARBStartPressed);
    on<ARBStartOn>(_onARBStartOn);
    on<ARBStartOff>(_onARBStartOff);
    on<ARBStopPressed>(_onARBStopPressed);
    on<ARBStopOn>(_onARBStopOn);
    on<ARBStopOff>(_onARBStopOff);
    on<ARBLogPressed>(_onARBLogPressed);
    on<ARBLogOn>(_onARBLogOn);
    on<ARBLogOff>(_onARBLogOff);
    on<ARBSettingsPressed>(_onARBSettingsPressed);
    on<ARBSettingsOn>(_onARBSettingsOn);
    on<ARBSettingsOff>(_onARBSettingsOff);
  }

  final SysBloc _sysBloc;
  late StreamSubscription<SysState> _sysBlocSubscription;

  Future<void> _onARBStartPressed(ARBStartPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.startRequested);
    emit(state.copyWith(ARBStart: ARBState.loading));
  }

  Future<void> _onARBStartOn(ARBStartOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBStart: ARBState.selected));
  }

  Future<void> _onARBStartOff(ARBStartOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBStart: ARBState.unselected));
  }

  Future<void> _onARBStopPressed(ARBStopPressed event, Emitter<UIState> emit) async {
    _sysBloc.add(SysEvent.stopRequested);
    emit(state.copyWith(ARBStop: ARBState.loading));
  }

  Future<void> _onARBStopOn(ARBStopOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBStop: ARBState.selected));
  }

  Future<void> _onARBStopOff(ARBStopOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBStop: ARBState.unselected));
  }

  Future<void> _onARBLogPressed(ARBLogPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBLog: ARBState.loading));
  }

  Future<void> _onARBLogOn(ARBLogOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBLog: ARBState.selected));
  }

  Future<void> _onARBLogOff(ARBLogOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBLog: ARBState.unselected));
  }

  Future<void> _onARBSettingsPressed(ARBSettingsPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBSettings: ARBState.loading));
  }

  Future<void> _onARBSettingsOn(ARBSettingsOn event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBSettings: ARBState.selected));
  }

  Future<void> _onARBSettingsOff(ARBSettingsOff event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBSettings: ARBState.unselected));
  }

  @override
  Future<void> close() {
    _sysBlocSubscription.cancel();
    return super.close();
  }
}

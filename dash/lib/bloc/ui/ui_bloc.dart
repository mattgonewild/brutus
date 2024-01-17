import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  UIBloc() : super(const UIState()) {
    on<ARBStartPressed>(_onARBStartPressed);
    on<ARBStopPressed>(_onARBStopPressed);
    on<ARBLogPressed>(_onARBLogPressed);
    on<ARBSettingsPressed>(_onARBSettingsPressed);
  }

  Future<void> _onARBStartPressed(ARBStartPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBStart: !state.ARBStart));
  }

  Future<void> _onARBStopPressed(ARBStopPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBStop: !state.ARBStop));
  }

  Future<void> _onARBLogPressed(ARBLogPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBLog: !state.ARBLog));
  }

  Future<void> _onARBSettingsPressed(ARBSettingsPressed event, Emitter<UIState> emit) async {
    emit(state.copyWith(ARBSettings: !state.ARBSettings));
  }
}

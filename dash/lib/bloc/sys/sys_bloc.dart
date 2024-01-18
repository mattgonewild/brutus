import 'package:bloc/bloc.dart';
import 'package:dash/repo/sys_repo.dart';

part 'sys_event.dart';
part 'sys_state.dart';

class SysBloc extends Bloc<SysEvent, SysState> {
  SysBloc({required SysRepo sysRepo}) : _sysRepo = sysRepo, super(SysState.unknown) {
    on<SysEvent>(_onSysEvent);
  }

  final SysRepo _sysRepo;

  Future<void> _onSysEvent(SysEvent event, Emitter<SysState> emit) async {
    switch (event) {
      case SysEvent.startRequested:
        emit(SysState.running);
      case SysEvent.stopRequested:
        emit(SysState.stopped);
    }
  }
}

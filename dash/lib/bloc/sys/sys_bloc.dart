import 'package:bloc/bloc.dart';
import 'package:dash/repo/sys_repo.dart';
import 'package:equatable/equatable.dart';

part 'sys_event.dart';
part 'sys_state.dart';

class SysBloc extends Bloc<SysEvent, SysState> {
  SysBloc({required SysRepo sysRepo})
      : _sysRepo = sysRepo,
        super(const SysState());

  final SysRepo _sysRepo;
}

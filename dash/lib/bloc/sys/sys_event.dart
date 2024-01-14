part of 'sys_bloc.dart';

sealed class SysEvent extends Equatable {
  const SysEvent();

  @override
  List<Object> get props => [];
}

final class SysStart extends SysEvent {
  const SysStart();
}

final class SysStop extends SysEvent {
  const SysStop();
}

final class SysShutdown extends SysEvent {
  const SysShutdown();
}
import 'package:bloc/bloc.dart';
import 'package:dash/repo/conf_repo.dart';
import 'package:equatable/equatable.dart';

part 'conf_event.dart';
part 'conf_state.dart';

class ConfBloc extends Bloc<ConfEvent, ConfState> {
  ConfBloc({required ConfRepo confRepo})
      : _confRepo = confRepo,
        super(const ConfState());

  final ConfRepo _confRepo;
}

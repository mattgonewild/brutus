part of 'conf_amal.dart';

class ConfBloc extends Bloc<ConfEvent, ConfState> {
  ConfBloc({required ConfRepo confRepo})
      : _confRepo = confRepo,
        super(const ConfState());

  final ConfRepo _confRepo;
}

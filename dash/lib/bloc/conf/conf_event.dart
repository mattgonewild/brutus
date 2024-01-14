part of 'conf_bloc.dart';

sealed class ConfEvent extends Equatable {
  const ConfEvent();

  @override
  List<Object> get props => [];
}

final class ConfAddElement extends ConfEvent {
  const ConfAddElement();
}

final class ConfRemoveElement extends ConfEvent {
  const ConfRemoveElement();
}

final class ConfIncreaseBudget extends ConfEvent {
  const ConfIncreaseBudget();
}

final class ConfDecreaseBudget extends ConfEvent {
  const ConfDecreaseBudget();
}

final class ConfUpdateTarget extends ConfEvent {
  const ConfUpdateTarget();
}

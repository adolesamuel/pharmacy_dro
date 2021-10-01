part of 'pharm_bloc.dart';

@immutable
abstract class PharmState {}

class PharmInitial extends PharmState {}

class FailedState extends PharmState {
  final Failure failure;

  FailedState(this.failure);
}

class LoadingState extends PharmState {}

class GotDrugsState extends PharmState {
  final List<Drug> drugs;

  GotDrugsState(this.drugs);
}

class ActionSuccessfulState extends PharmState {
  final bool status;

  ActionSuccessfulState(this.status);
}

class GotDrugsFromCartState extends PharmState {
  final List<Drug> cartDrugs;

  GotDrugsFromCartState(this.cartDrugs);
}

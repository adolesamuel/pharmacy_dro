part of 'pharm_bloc.dart';

@immutable
abstract class PharmEvent {}

class GetDrugsEvent extends PharmEvent {}

class AddDrugToCartEvent extends PharmEvent {
  final Drug newDrug;

  AddDrugToCartEvent(this.newDrug);
}

class RemoveDrugFromCartEvent extends PharmEvent {
  final Drug presentDrug;

  RemoveDrugFromCartEvent(this.presentDrug);
}

class RemoveAllDrugsFromCartEvent extends PharmEvent {}

class GetDrugsFromCart extends PharmEvent {}

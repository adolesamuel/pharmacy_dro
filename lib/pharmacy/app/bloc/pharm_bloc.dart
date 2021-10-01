import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy_dro/core/failure.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

part 'pharm_event.dart';
part 'pharm_state.dart';

class PharmBloc extends Bloc<PharmEvent, PharmState> {
  PharmBloc() : super(PharmInitial()) {
    on<PharmEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

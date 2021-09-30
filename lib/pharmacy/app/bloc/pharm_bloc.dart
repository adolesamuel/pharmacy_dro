import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pharm_event.dart';
part 'pharm_state.dart';

class PharmBloc extends Bloc<PharmEvent, PharmState> {
  PharmBloc() : super(PharmInitial()) {
    on<PharmEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

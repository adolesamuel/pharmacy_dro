import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy_dro/core/failure.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';
import 'package:pharmacy_dro/pharmacy/data/repository/pharmacy_repo.dart';

part 'pharm_event.dart';
part 'pharm_state.dart';

class PharmBloc extends Bloc<PharmEvent, PharmState> {
  final DrugRepository drugRepository;
  PharmBloc(this.drugRepository) : super(PharmInitial()) {
    on<PharmEvent>((event, emit) {
      on<GetDrugsEvent>((event, emit) async {
        final drugRepoResultOrError = await drugRepository.getDrugs();
        drugRepoResultOrError.fold(
            (l) => emit(FailedState(l)), (r) => emit(GotDrugsState(r)));
      });

      on<AddDrugToCartEvent>((event, emit) async {
        final drugRepoResultOrError =
            await drugRepository.addDrugtoCart(event.newDrug);
        drugRepoResultOrError.fold(
            (l) => emit(FailedState(l)), (r) => emit(ActionSuccessfulState(r)));
      });

      on<RemoveDrugFromCartEvent>((event, emit) async {
        final drugRepoResultOrError =
            await drugRepository.removeDrugFromCart(event.presentDrug);

        drugRepoResultOrError.fold(
            (l) => emit(FailedState(l)), (r) => emit(ActionSuccessfulState(r)));
      });

      on<RemoveAllDrugsFromCartEvent>((event, emit) async {
        final drugRepoOrError = await drugRepository.removeAllDrugsFromCart();

        drugRepoOrError.fold(
            (l) => emit(FailedState(l)), (r) => ActionSuccessfulState(r));
      });

      on<GetDrugsFromCart>((event, emit) async {
        final drugRepoOrError = await drugRepository.getDrugsFromCart();

        drugRepoOrError.fold(
            (l) => FailedState(l), (r) => emit(GotDrugsFromCartState(r)));
      });
    });
  }
}

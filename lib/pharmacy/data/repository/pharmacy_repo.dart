import 'package:dartz/dartz.dart';
import 'package:pharmacy_dro/core/failure.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/local_source.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/remote_source.dart';

//This will perform a function for every version that is called
class DrugRepository {
  final DrugRemoteDataSource drugRemoteDataSource;
  final DrugLocalDataSource drugLocalDataSource;

  DrugRepository(this.drugRemoteDataSource, this.drugLocalDataSource);

  Future<Either<Failure, List<Drug>>> getDrugs() async {
    try {
      //get drugs from remote
      return Right(await drugRemoteDataSource
          .getDrugsList()
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception('Timeout Error');
      }));
    } on Exception catch (e) {
      return Left(Failure('Error from Get Drugs', e.toString()));
    }
  }

  Future<Either<Failure, bool>> addDrugtoCart(Drug newDrug) async {
    try {
      //add to cart and return true
      return Right(await drugLocalDataSource
          .addDrugToCart(newDrug)
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception('Time out Error ');
      }));
    } on Exception catch (e) {
      return Left(Failure('Error from Add to Cart', e.toString()));
    }
  }

  Future<Either<Failure, bool>> removeDrugFromCart(Drug presentDrug) async {
    try {
      return Right(await drugLocalDataSource
          .removeDrugFromCart(presentDrug)
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception('Time out Error ');
      }));
    } on Exception catch (e) {
      return Left(Failure('Error from remove from Cart', e.toString()));
    }
  }

  Future<Either<Failure, bool>> removeAllDrugsFromCart() async {
    try {
      return Right(await drugLocalDataSource
          .removeAllDrugsFromCart()
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception('Time out Error ');
      }));
    } on Exception catch (e) {
      return Left(
          Failure('Error from remove all drugs from Cart', e.toString()));
    }
  }

  Future<Either<Failure, List<Drug>>> getDrugsFromCart() async {
    try {
      return Right(await drugLocalDataSource
          .getDrugsInCart()
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception('Time out Error ');
      }));
    } on Exception catch (e) {
      return Left(Failure('Error from Get all drugs from cart', e.toString()));
    }
  }
}

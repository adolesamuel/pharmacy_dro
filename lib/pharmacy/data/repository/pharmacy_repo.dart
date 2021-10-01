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


  Future<Either<Failure,bool>> addDrugtoCart() async{
    try{
      //add to cart and return true
      return Right(await drugLocalDataSource.addDrugtoCart())
    }on Exception catch(e){
      return Left(Failure())
    }
  }
}

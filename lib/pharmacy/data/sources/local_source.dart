//this queries the local data source Hive
import 'package:hive/hive.dart';

class DrugLocalDataSource {
  Future<bool> addDrugToCart(Drug drug) async {
    final box = await Hive.openBox('Cart');
  }
}

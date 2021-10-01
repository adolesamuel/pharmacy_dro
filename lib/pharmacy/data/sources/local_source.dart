//this queries the local data source Hive
import 'package:hive/hive.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class DrugLocalDataSource {
  Future<bool> addDrugToCart(Drug newDrug) async {
    final cartbox = await Hive.openBox('cart');
    List<Drug> drugs = [];
    try {
      List<String> drugsAsStringList = [];
      final currentStrings = cartbox.get('cart');

      if (currentStrings != null) {
        for (final String string in currentStrings) {
          final drug = Drug.fromJson(string);
          drugs.add(drug);
        }
        drugs.add(newDrug);
        for (final drug in drugs) {
          final drugString = drug.toJson();
          drugsAsStringList.add(drugString);
        }
      } else {
        drugsAsStringList.add(newDrug.toJson());
      }
      await cartbox.put('cart', drugsAsStringList);
      return true;
    } catch (e) {
      throw Exception('Add Drug to Cart Error');
    } finally {
      cartbox.close();
    }
  }

  Future<bool> removeDrugFromCart(Drug presentDrug) async {
    final cartbox = await Hive.openBox('cart');
    List<Drug> drugs = [];
    try {
      List<String> drugsAsStringList = [];
      final currentStrings = cartbox.get('cart');

      if (currentStrings != null) {
        for (final String string in currentStrings) {
          final drug = Drug.fromJson(string);
          drugs.add(drug);
        }
        drugs.remove(presentDrug); //actual remove function
        for (final drug in drugs) {
          final drugString = drug.toJson();
          drugsAsStringList.add(drugString);
        }
      }
      await cartbox.put('cart', drugsAsStringList);
      return true;
    } catch (e) {
      throw Exception('Remove Drug From Cart Error');
    } finally {
      cartbox.close();
    }
  }

  Future<List<Drug>> getDrugsInCart() async {
    final box = await Hive.openBox('cart');
    List<Drug> drugs = [];

    try {
      final drugsAsStringList = box.get('cart');
      if (drugsAsStringList != null) {
        for (final String drugString in drugsAsStringList) {
          final drug = Drug.fromJson(drugString);
          drugs.add(drug);
        }
        return drugs;
      } else {
        return drugs;
      }
    } catch (e) {
      throw Exception('Get Drugs Error');
    } finally {
      box.close();
    }
  }

  Future<bool> removeAllDrugsFromCart() async {
    final box = await Hive.openBox('cart');
    List<String> empty = [];
    try {
      await box.put('cart', empty);
      return true;
    } catch (e) {
      throw Exception('Remove all drugs Error');
    } finally {
      box.close();
    }
  }
}

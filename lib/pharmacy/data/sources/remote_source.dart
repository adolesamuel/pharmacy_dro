//This queries the remote source
//could be a url or in this case stored mock data
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class DrugRemoteDataSource {
  Future<List<Drug>> getDrugsList() {
    //will create a mock list of drugs here and return them after 0.5seconds
    //the drug images will be placed in the asset folders for easy reach
    //lbuProfen
    Drug lbuProfenRed = Drug(
      drugId: '1',
      drugName: 'Lbuprofen',
      drugForm: 'Tablet',
      massPerTab: '400mg',
      imageUrl: 'assets/lbuprofen400.png',
      requiresPrescription: false,
      retailPricePerPack: 350.00,
      drugCategory: 'Headache',
      manufacturerName: 'Numark',
      manufacturerImageUrl: 'assets/numark.jpg',
      packSize: '2 x 12 tablets (24)',
      productId: 'ZXC90923',
      constituents: 'lbuprofen',
      dispensedUnit: 'pack',
    );

    Drug panadolExtra = Drug(
      drugId: '2',
      drugName: 'Panadol Extra',
      drugForm: 'Tablet',
      massPerTab: '500mg',
      imageUrl: 'assets/panadol.jpg',
      requiresPrescription: false,
      retailPricePerPack: 350.00,
      drugCategory: 'Headache',
      manufacturerName: 'GSK',
      manufacturerImageUrl: 'assets/gsk-logo.png',
      packSize: '3 x 8 tablets (24)',
      productId: 'ABO89023012',
      constituents: 'Panadol',
      dispensedUnit: 'pack',
    );

    Drug doliprane = Drug(
      drugId: '3',
      drugName: 'Doliprane',
      drugForm: 'Tablet',
      massPerTab: '1000mg',
      imageUrl: 'assets/doliprane.jpg',
      requiresPrescription: true,
      retailPricePerPack: 350.00,
      drugCategory: 'Headache',
      manufacturerName: 'Sanofi',
      manufacturerImageUrl: 'assets/sanofi.jpg',
      packSize: '2 x 4 tablets (8)',
      productId: 'GBO23405543',
      constituents: 'Paracetamol',
      dispensedUnit: 'pack',
    );

    Drug vitamin = Drug(
      drugId: '4',
      drugName: 'C-1000 Vitamin C',
      drugForm: 'Syrup',
      massPerTab: '1000cl',
      imageUrl: 'assets/vitamin.jpg',
      requiresPrescription: true,
      retailPricePerPack: 2000.00,
      drugCategory: 'Supplements',
      manufacturerName: 'Nature\'s Bounty',
      manufacturerImageUrl: 'assets/nature.jpg',
      packSize: '100 tablets',
      productId: 'GHA83932234',
      constituents: 'Vitamin - C',
      dispensedUnit: 'bottle',
    );

    Drug syrup = Drug(
      drugId: '5',
      drugName: 'Amoxil',
      drugForm: 'Syrup',
      massPerTab: '125mg/5ml',
      imageUrl: 'assets/amoxil.jpg',
      requiresPrescription: true,
      retailPricePerPack: 1000.00,
      drugCategory: 'antibiotic',
      manufacturerName: 'GSK',
      manufacturerImageUrl: 'assets/gsk-logo.png',
      packSize: '100ml',
      productId: 'HFW19282098',
      constituents: 'amoxicillin',
      dispensedUnit: 'Bottles',
    );

    Drug emzor = Drug(
      drugId: '6',
      drugName: 'Paracetamol',
      drugForm: 'Tablet',
      massPerTab: '500mg',
      imageUrl: 'assets/paracetamol.jpg',
      requiresPrescription: false,
      retailPricePerPack: 350.00,
      drugCategory: 'Headache',
      manufacturerName: 'Emzor',
      manufacturerImageUrl: 'assets/emzor.jpg',
      packSize: '8 x 12 tablets (96)',
      productId: 'PRO23648856',
      constituents: 'Paracetamol',
      dispensedUnit: 'Packs',
    );

    List<Drug> listOfDrugs = [
      lbuProfenRed,
      panadolExtra,
      doliprane,
      vitamin,
      syrup,
      emzor,
    ];

    return Future.delayed(Duration(seconds: 1), () {
      return listOfDrugs;
    });
  }
}

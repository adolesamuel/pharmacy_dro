import 'dart:convert';

class Drug {
  //drugId
  final String drugId;

  ///Actual name of the drug
  final String drugName;

  ///state of the drug i.e tablet or capsule
  final String drugForm;

  ///percapsulesize i.e 500mg
  final String massPerTab;

  ///drugImage
  final String imageUrl;

  ///requires prescription
  final bool requiresPrescription;

  ///retail price in Naira
  final int retailPricePerPack;

  ///category of drug i.e for Headaches or Supplements
  final String drugCategory;

  ///manufacturer name
  final String manufacturerName;

  ///retailer image url
  final String manufacturerImageUrl;

  ///pack size i.e 8 x 12 tablets (96)
  final String packSize;

  ///product id
  final String productId;

  ///constituents i.e active components
  final String constituents;

  ///mode of dispensation. i.e packs
  final String dispensedUnit;

  Drug({
    required this.drugId,
    required this.drugName,
    required this.drugForm,
    required this.massPerTab,
    required this.imageUrl,
    required this.requiresPrescription,
    required this.retailPricePerPack,
    required this.drugCategory,
    required this.manufacturerName,
    required this.manufacturerImageUrl,
    required this.packSize,
    required this.productId,
    required this.constituents,
    required this.dispensedUnit,
  });

  factory Drug.fromMap(Map map) {
    return Drug(
      drugId: map['drug_id'],
      drugName: map['drug_name'],
      drugForm: map['drug_form'],
      massPerTab: map['mass_per_tab'],
      imageUrl: map['drug_image'],
      requiresPrescription: map['needPrescription'],
      retailPricePerPack: map['price_per_pack'],
      drugCategory: map['drug_category'],
      manufacturerName: map['manufacturer'],
      manufacturerImageUrl: map['manufacturerImage'],
      packSize: map['pack_size'],
      productId: map['product_id'],
      constituents: map['constituents'],
      dispensedUnit: map['dispensed_unit'],
    );
  }

  factory Drug.fromJson(String jsonData) {
    //Actually a jsonObject
    final map = json.decode(jsonData);
    return Drug(
      drugId: map['drug_id'],
      drugName: map['drug_name'],
      drugForm: map['drug_form'],
      massPerTab: map['mass_per_tab'],
      imageUrl: map['drug_image'],
      requiresPrescription: map['needPrescription'],
      retailPricePerPack: map['price_per_pack'],
      drugCategory: map['drug_category'],
      manufacturerName: map['manufacturer'],
      manufacturerImageUrl: map['manufacturerImage'],
      packSize: map['pack_size'],
      productId: map['product_id'],
      constituents: map['constituents'],
      dispensedUnit: map['dispensed_unit'],
    );
  }

  String toJson() {
    //convert the drug to jsonobject
    Map<String, dynamic> mapObject = {
      'drug_id': drugId,
      'drug_name': drugName,
      'drug_form': drugForm,
      'mass_per_tab': massPerTab,
      'drug_image': imageUrl,
      'needPrescription': requiresPrescription,
      'price_per_pack': retailPricePerPack,
      'drug_category': drugCategory,
      'manufacturer': manufacturerName,
      'manufacturerImage': manufacturerImageUrl,
      'pack_size': packSize,
      'product_id': productId,
      'constituents': constituents,
      'dispensed_unit': dispensedUnit,
    };

    return json.encode(mapObject);
  }
}

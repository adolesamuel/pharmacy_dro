import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class DrugListItem extends StatelessWidget {
  final Drug drug;
  const DrugListItem({Key? key, required this.drug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName.toString());
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.3,
            height: size.height * 0.15,
            color: Colors.grey,
            child: Image.asset(
              drug.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.0),
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(drug.drugName),
                Row(
                  children: [
                    Text(
                      drug.drugForm,
                    ),
                    Icon(
                      Icons.circle,
                      size: 4,
                    ),
                    Text(drug.massPerTab)
                  ],
                ),
                Text(format.currencySymbol +
                    ' ' +
                    drug.retailPricePerPack.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

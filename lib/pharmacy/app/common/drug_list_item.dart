import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class DrugListItem extends StatelessWidget {
  final Drug drug;
  final Function()? onPressed;
  const DrugListItem({Key? key, required this.drug, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 2,
      shadowColor: Colors.white,
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Container(
          width: size.width * 0.35,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
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
                  if (drug.requiresPrescription)
                    Container(
                      padding: EdgeInsets.all(2.0),
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          'Requires a prescription',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    )
                ],
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(drug.drugName),
                    Row(
                      children: [
                        Text(
                          drug.drugForm,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Icon(
                          Icons.circle,
                          size: 4,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          drug.massPerTab,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                    Text(
                      format.currencySymbol +
                          drug.retailPricePerPack.toStringAsFixed(2),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

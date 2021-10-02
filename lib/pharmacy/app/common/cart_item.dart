import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_dro/core/appColors.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class CartItem extends StatelessWidget {
  final Drug drug;
  final Function()? clickRemove;
  const CartItem({Key? key, required this.drug, this.clickRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return Container(
      padding: EdgeInsets.all(10.0),
      width: size.width,
      height: size.height * 0.131,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(drug.imageUrl),
              SizedBox(
                width: 8.0,
              ),
              Column(
                children: [
                  Text(drug.drugName),
                  SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: [
                      Text(
                        drug.drugForm + ' ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(
                        Icons.circle,
                        size: 4,
                        color: Colors.grey,
                      ),
                      Text(
                        ' ' + drug.massPerTab,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    format.currencySymbol +
                        drug.retailPricePerPack.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Text('1'),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.dROPurple,
                    )
                  ],
                ),
              ),
              TextButton.icon(
                  onPressed: clickRemove,
                  icon: Icon(Icons.delete),
                  label: Text('Remove'))
            ],
          )
        ],
      ),
    );
  }
}

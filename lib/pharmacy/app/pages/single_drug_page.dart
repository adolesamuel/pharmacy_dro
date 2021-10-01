import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_dro/core/appColors.dart';
import 'package:pharmacy_dro/pharmacy/app/common/appbar_with_search.dart';
import 'package:pharmacy_dro/pharmacy/app/common/elevated_long_button.dart';
import 'package:pharmacy_dro/pharmacy/app/common/product_detail_card.dart';
import 'package:pharmacy_dro/pharmacy/app/common/similar_product_slider.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class SingleDrugPage extends StatefulWidget {
  final Drug drug;
  const SingleDrugPage({Key? key, required this.drug}) : super(key: key);

  @override
  _SingleDrugPageState createState() => _SingleDrugPageState();
}

class _SingleDrugPageState extends State<SingleDrugPage> {
  @override
  Widget build(BuildContext context) {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return Scaffold(
      appBar: SearchAppBar(
        hasSearchBar: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image(
              image: AssetImage(widget.drug.imageUrl),
            ),
            Text(widget.drug.drugName),
            Text(widget.drug.drugForm + ' - ' + widget.drug.massPerTab),
            Row(children: [
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                child:
                    Image(image: AssetImage(widget.drug.manufacturerImageUrl)),
              ),
              Column(
                children: [Text('SOLD BY'), Text(widget.drug.manufacturerName)],
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.remove)),
                          Text('1'),
                          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(widget.drug.dispensedUnit + ('(s)')),
                  ],
                ),
                Text(format.currencySymbol +
                    ' ' +
                    widget.drug.retailPricePerPack.toStringAsFixed(2)),
              ],
            ),
            ProductDetailCard(drug: widget.drug),
            SimilarProductSlider(),
            ElevatedLongBarButton(
              text: 'Add to Cart',
              onPressed: () {},
            ),
          ],
        ),
      ),
      //,
    );
  }
}

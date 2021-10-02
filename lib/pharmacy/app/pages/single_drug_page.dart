import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_dro/core/appColors.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/common/appbar_with_search.dart';
import 'package:pharmacy_dro/pharmacy/app/common/elevated_long_button.dart';
import 'package:pharmacy_dro/pharmacy/app/common/product_detail_card.dart';
import 'package:pharmacy_dro/pharmacy/app/common/similar_product_slider.dart';
import 'package:pharmacy_dro/pharmacy/app/pages/cart_page.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';
import 'package:pharmacy_dro/pharmacy/data/repository/pharmacy_repo.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/local_source.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/remote_source.dart';

class SingleDrugPage extends StatefulWidget {
  final Drug drug;
  const SingleDrugPage({Key? key, required this.drug}) : super(key: key);

  @override
  _SingleDrugPageState createState() => _SingleDrugPageState();
}

class _SingleDrugPageState extends State<SingleDrugPage> {
  String computeText(Drug drug) {
    return '${drug.manufacturerName} ${drug.drugName} has been successfully added to cart!';
  }

  Future showAddToCartBottomSheet(BuildContext context, Drug drug) {
    return showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20.0),
            height: 300,
            width: 300,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  computeText(drug),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                Column(
                  children: [
                    ElevatedLongBarButton(
                      text: 'VIEW CART',
                      showShoppingCart: false,
                      onPressed: () {
                        //navigate to cart
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()));
                      },
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              side: BorderSide(color: AppColors.dROPurple)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'CONTINUE SHOPPING',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.dROPurple),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
          );
        });
  }

  PharmBloc pharmBloc = PharmBloc(
    DrugRepository(
      DrugRemoteDataSource(),
      DrugLocalDataSource(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return Scaffold(
      appBar: SearchAppBar(
        hasSearchBar: false,
        hasFavourite: false,
        onTapCart: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image(
              image: AssetImage(widget.drug.imageUrl),
              height: 150.0,
            ),
            SizedBox(
              height: 4.0,
            ),
            Center(
              child: Text(
                widget.drug.drugName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                widget.drug.drugForm + ' - ' + widget.drug.massPerTab,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            //Manufacturer Name bar
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.white,
                    child: Image(
                        image: AssetImage(widget.drug.manufacturerImageUrl)),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    children: [
                      Text(
                        'SOLD BY',
                        style: TextStyle(
                            color: AppColors.dROMiddleBlue, fontSize: 10),
                      ),
                      Text(
                        widget.drug.manufacturerName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade700),
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_outline,
                    color: AppColors.dROPurple,
                  )),
            ]),

            SizedBox(
              height: 20,
            ),

            //Change Count bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      height: 37.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          InkWell(onTap: () {}, child: Icon(Icons.remove)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('1'),
                          ),
                          InkWell(onTap: () {}, child: Icon(Icons.add)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      widget.drug.dispensedUnit + ('(s)'),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  format.currencySymbol +
                      widget.drug.retailPricePerPack.toStringAsFixed(2),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
            //Product Details bar
            SizedBox(height: 24.0),
            ProductDetailCard(drug: widget.drug),
            SimilarProductSlider(),
            ElevatedLongBarButton(
              text: 'Add to Cart',
              onPressed: () {
                //add drug to cart.
                pharmBloc.add(AddDrugToCartEvent(widget.drug));
                //Show confirmation sheet
                showAddToCartBottomSheet(context, widget.drug);
              },
            ),
          ],
        ),
      ),
      //,
    );
  }
}

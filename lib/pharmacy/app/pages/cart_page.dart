import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/common/appbar_with_search.dart';
import 'package:pharmacy_dro/pharmacy/app/common/cart_item.dart';
import 'package:pharmacy_dro/pharmacy/app/common/elevated_long_button.dart';
import 'package:pharmacy_dro/pharmacy/app/common/empty_cart.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';
import 'package:pharmacy_dro/pharmacy/data/repository/pharmacy_repo.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/local_source.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/remote_source.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double sum = 0.0;
  List<Drug> drugs = [];
  PharmBloc pharmBloc = PharmBloc(
    DrugRepository(
      DrugRemoteDataSource(),
      DrugLocalDataSource(),
    ),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pharmBloc.close();
  }

  void sumThePrices(List<Drug> drugs) {
    sum = 0.0;
    for (Drug drug in drugs) {
      sum += drug.retailPricePerPack;
    }
  }

  @override
  Widget build(BuildContext context) {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

    return Scaffold(
      appBar: SearchAppBar(
        hasSearchBar: false,
        hasCart: false,
        title: Row(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'Cart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //the list contents
          BlocProvider<PharmBloc>(
            create: (context) => pharmBloc..add(GetDrugsFromCartEvent()),
            child: BlocConsumer<PharmBloc, PharmState>(
              listener: (context, state) {
                if (state is GotDrugsFromCartState) {
                  drugs = state.cartDrugs;
                  sumThePrices(state.cartDrugs);
                  setState(() {});
                }
                if (state is ActionSuccessfulState) {
                  pharmBloc.add(GetDrugsFromCartEvent());
                }
              },
              builder: (context, state) {
                if (state is GotDrugsFromCartState) {
                  if (state.cartDrugs.isEmpty) {
                    return EmptyCart();
                  }
                  //Testing out a different combined listview
                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1.0,
                          );
                        },
                        itemCount: state.cartDrugs.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            drug: state.cartDrugs[index],
                            clickRemove: () {
                              pharmBloc.add(RemoveDrugFromCartEvent(
                                  state.cartDrugs[index]));
                            },
                          );
                        }),
                  );
                }
                if (drugs.isEmpty) {
                  return EmptyCart();
                } else {
                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1.0,
                          );
                        },
                        itemCount: drugs.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            drug: drugs[index],
                            clickRemove: () {
                              pharmBloc
                                  .add(RemoveDrugFromCartEvent(drugs[index]));
                            },
                          );
                        }),
                  );
                }
              },
            ),
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Total: '),
                        Text(
                          format.currencySymbol + sum.toStringAsFixed(2),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedLongBarButton(
                          showShoppingCart: false,
                          text: 'CHECKOUT',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(20.0),
                                    height: 100.0,
                                    child: Center(
                                        child: Text('Still in Progress!')),
                                  );
                                });
                          },
                        ))
                  ])),
        ],
      ),
    );
  }
}

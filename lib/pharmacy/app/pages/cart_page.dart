import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/common/appbar_with_search.dart';
import 'package:pharmacy_dro/pharmacy/app/common/cart_item.dart';
import 'package:pharmacy_dro/pharmacy/app/common/elevated_long_button.dart';
import 'package:pharmacy_dro/pharmacy/app/common/empty_cart.dart';
import 'package:pharmacy_dro/pharmacy/data/repository/pharmacy_repo.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/local_source.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/remote_source.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            Text('Cart'),
          ],
        ),
      ),
      body: BlocProvider<PharmBloc>(
        create: (context) => pharmBloc..add(GetDrugsFromCartEvent()),
        child: BlocConsumer<PharmBloc, PharmState>(
          listener: (context, state) {
            if (state is GotDrugsFromCartState) {
              print(state.cartDrugs);
            }
          },
          builder: (context, state) {
            if (state is GotDrugsFromCartState) {
              if (state.cartDrugs.isEmpty) {
                return EmptyCart();
              }
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1.0,
                    );
                  },
                  itemCount: state.cartDrugs.length,
                  itemBuilder: (context, index) {
                    return CartItem(drug: state.cartDrugs[index]);
                    // return ListTile(
                    //   leading: Image.asset(state.cartDrugs[index].imageUrl),
                    //   title: Text(state.cartDrugs[index].drugName),
                    //   subtitle: Text(state.cartDrugs[index].retailPricePerPack
                    //       .toStringAsFixed(2)),
                    //   isThreeLine: true,
                    //   trailing: Column(
                    //     children: [
                    //       DropdownButton(items: [
                    //         DropdownMenuItem(
                    //           child: Text('1'),
                    //         ),
                    //       ]),
                    //       // TextButton.icon(
                    //       //     onPressed: () {},
                    //       //     icon: Icon(
                    //       //       Icons.delete,
                    //       //       size: 10,
                    //       //     ),
                    //       //     label: Text(
                    //       //       'Remove',
                    //       //       style: TextStyle(fontSize: 12),
                    //       //     )),
                    //     ],
                    //   ),
                    // );
                  });
            }
            return Container(
              color: Colors.green,
            );
          },
        ),
      ),
      bottomSheet: Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width * 0.9,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Total: 0.00'),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedLongBarButton(
                    showShoppingCart: false, text: 'CHECKOUT'))
          ])),
    );
  }
}

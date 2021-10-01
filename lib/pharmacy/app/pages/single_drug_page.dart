import 'package:flutter/material.dart';
import 'package:pharmacy_dro/pharmacy/app/common/appbar_with_search.dart';
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
    return Scaffold(
      appBar: SearchAppBar(
        hasSearchBar: false,
      ),
      body: Container(),
      //,
    );
  }
}

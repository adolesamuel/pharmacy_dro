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
      body: Container(
        child: Column(
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
            ])
          ],
        ),
      ),
      //,
    );
  }
}

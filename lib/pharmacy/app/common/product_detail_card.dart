import 'package:flutter/material.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class ProductDetailCard extends StatelessWidget {
  final Drug drug;
  const ProductDetailCard({Key? key, required this.drug}) : super(key: key);

  String computeDescription(Drug drug) {
    return '1 ${drug.dispensedUnit} of ${drug.manufacturerName} ${drug.drugName} ' +
        '(${drug.massPerTab}) contains ${drug.packSize}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('PRODUCT DETAILS'),
          Row(
            children: [
              DetailItem(
                  icon: Icon(Icons.tablet),
                  detail: 'PACK SIZE',
                  detailContent: drug.packSize),
              DetailItem(
                  icon: Icon(Icons.tablet),
                  detail: 'PRODUCT ID',
                  detailContent: drug.productId),
            ],
          ),
          Row(
            children: [
              DetailItem(
                  icon: Icon(Icons.tablet),
                  detail: 'CONSTITUENTS',
                  detailContent: drug.constituents),
              DetailItem(
                  icon: Icon(Icons.tablet),
                  detail: 'DISPENSED IN',
                  detailContent: drug.dispensedUnit),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: Text(computeDescription(drug)),
          )
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final Icon icon;
  final String detail;
  final String detailContent;
  const DetailItem({
    Key? key,
    required this.icon,
    required this.detail,
    required this.detailContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.backpack),
          Column(
            children: [Text(detail), Text(detailContent)],
          )
        ],
      ),
    );
  }
}

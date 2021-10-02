import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_dro/core/appColors.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PRODUCT DETAILS',
            style: TextStyle(
              color: AppColors.dROdarkBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Row(
            children: [
              DetailItem(
                  iconAsset: 'assets/capsules.png',
                  detail: 'PACK SIZE',
                  detailContent: drug.packSize),
              DetailItem(
                  iconAsset: 'assets/menu.png',
                  detail: 'PRODUCT ID',
                  detailContent: drug.productId),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              DetailItem(
                  iconAsset: 'assets/pill.png',
                  detail: 'CONSTITUENTS',
                  detailContent: drug.constituents),
              DetailItem(
                  iconAsset: 'assets/pills-bottle.png',
                  detail: 'DISPENSED IN',
                  detailContent: drug.dispensedUnit.toUpperCase() + 'S'),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            child: Text(
              computeDescription(drug),
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String iconAsset;
  final String detail;
  final String detailContent;
  const DetailItem({
    Key? key,
    required this.iconAsset,
    required this.detail,
    required this.detailContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: 30.0,
      child: Row(
        children: [
          Image.asset(
            iconAsset,
            height: 20,
            color: AppColors.dROPurple,
          ),
          SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail,
                style: TextStyle(fontSize: 9, color: AppColors.dROMiddleBlue),
              ),
              Text(detailContent,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: AppColors.dROdarkBlue))
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String assetString;
  final String categoriesString;
  final Function(String)? selectCategory;
  const CategoryWidget(
      {Key? key,
      required this.assetString,
      required this.categoriesString,
      this.selectCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        onTap: () {
          selectCategory!(categoriesString);
        },
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              height: size.height * 0.15,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(assetString), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: size.height * 0.15,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                  child: Text(
                categoriesString,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

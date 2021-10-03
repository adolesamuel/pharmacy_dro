import 'package:flutter/material.dart';

class EmptyCart extends StatefulWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  _EmptyCartState createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Center(
        child: Text(
          'Empty Cart',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

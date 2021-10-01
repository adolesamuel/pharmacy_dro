import 'package:flutter/material.dart';
import 'package:pharmacy_dro/core/appColors.dart';

class ElevatedLongBarButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const ElevatedLongBarButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: AppColors.DROPurpleGradient,
          borderRadius: BorderRadius.circular(10.0)),
      child: RawMaterialButton(
        elevation: 8.0,
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

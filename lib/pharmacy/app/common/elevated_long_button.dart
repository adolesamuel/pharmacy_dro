import 'package:flutter/material.dart';
import 'package:pharmacy_dro/core/appColors.dart';

class ElevatedLongBarButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool showShoppingCart;
  const ElevatedLongBarButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.showShoppingCart = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PhysicalModel(
        elevation: 8,
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: AppColors.dROPurple,
        color: AppColors.dROPurple,
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              gradient: AppColors.dROPurpleGradient,
              borderRadius: BorderRadius.circular(10.0)),
          child: RawMaterialButton(
            elevation: 8.0,
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showShoppingCart)
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Proxima-Nova',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

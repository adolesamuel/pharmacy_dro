import 'package:flutter/material.dart';

class AppColors {
  static final Color dROTurquoise = Color(0xFF0CB8B6);
  static final Color dROPurple = Color(0xFF9F5DE2);
  static final Color dROMiddleBlue = Color(0xFF5C86CE);
  static final Color dROdarkBlue = Colors.blueGrey.shade700;
  static final LinearGradient dROPurpleGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF7A08FA),
        Color(0xFFAD3BFC),
      ]);

  static final LinearGradient dRORedGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffFE806F),
        Color(0xffE5366A),
      ]);
}

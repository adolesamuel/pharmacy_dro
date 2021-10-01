import 'package:flutter/material.dart';

class AppColors {
  static final Color DROTurquoise = Color(0xFF0CB8B6);
  static final Color DROPurple = Color(0xFF9F5DE2);
  static final Color DROMiddleBlue = Color(0xFF5C86CE);
  static final LinearGradient DROPurpleGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF7A08FA),
        Color(0xFFAD3BFC),
      ]);

  static final LinearGradient DRORedGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffFE806F),
        Color(0xffE5366A),
      ]);
}

import 'package:flutter/material.dart';

class AppColors {
  static const baseColor = Color(0xFFA2AA7B);
  static const disableColor = Color(0xFFAFAFAF);
  static const disableBorderColor = Color(0xFFF0F0F0);
  static const activeBackgroundColor = Color(0xFFFFFAF5);
  static const whiteColor = Color(0xFFFFFFFF);

  static const MaterialColor baseMaterialColor = MaterialColor(
    0xFFA2AA7B,
    <int, Color>{
      50: Color(0xFFE1E6D9),
      100: Color(0xFFB5C0A8),
      200: Color(0xFF899276),
      300: Color(0xFF5C6C44),
      400: Color(0xFF425629),
      500: Color(0xFF2B3A0F), // the primary color value
      600: Color(0xFF27320C),
      700: Color(0xFF222B0A),
      800: Color(0xFF1E2508),
      900: Color(0xFF131803),
    },
  );
}

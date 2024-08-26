import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFD61355);
  static const Color secondary = Color.fromARGB(255, 245, 132, 132);
  static const Color red = Color(0xFFFF0000);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color yellow = Colors.yellow;
  static const Color silver = Color(0xFFA3AED0);
  static const Color textDarkColor = Color(0xFF2B3674);
  static const Color borderColor = Color(0xFFE0E5F2);
  static const Color backgroundColor = Color(0xFFF4F7FE);
  static Color grey = Colors.black.withOpacity(0.5);
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [
      Color(0xFFD61355),
      Color(0xFFFF0000),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient gradientSecondary = LinearGradient(colors: [
    Color(0xFFFFF0F0),
    Color(0xFFFFDFDF),
  ]);
  static const LinearGradient gradientCard = LinearGradient(colors: [
    Color(0xFFFF0000),
    Color(0xFFFFB4B4),
  ]);
  static const Color inactiveDotColor = Color(0xFFE6E6E6);
  static const LinearGradient gradientTextDarkColor = LinearGradient(
  colors: [
    Color(0xFF2B3674),
    Color(0xFF4C5A95),
    // Color(0xFF6C7AB8),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
}

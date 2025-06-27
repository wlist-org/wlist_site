import 'package:flutter/material.dart';

class CustomColors {
  static const Color primaryBlue = Color(0xFF3377EE);
  static const Color hoverBlue = Color(0xFF5599FF);
  static const Color buttonBlue = Color(0xFF007BFF);
  static const Color buttonHoverBlue = Color(0xFF0056B3);

  static const Color darkText = Color(0xFF333333);
  static const Color textGray = Color(0xFF555555);
  static const Color lightGray = Color(0xFF999999);

  static const Color backgroundBubble = Color(0x12FFA500); // rgba(255, 165, 0, 0.07)
}

TextStyle mergeTextStyleColor(TextStyle? textTheme, Color color) {
  final colored = TextStyle(color: color);
  return textTheme == null ? colored : textTheme.merge(colored);
}

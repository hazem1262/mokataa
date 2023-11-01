
import 'package:flutter/material.dart';

class AppFonts {
  static const String Urbanist = "Urbanist";
}

TextStyle urbanistRegular({required Color color, required, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: AppFonts.Urbanist,
    fontWeight: FontWeight.normal
  );
}

TextStyle urbanistMedium({required Color color, required, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: AppFonts.Urbanist,
    fontWeight: FontWeight.w500
  );
}


TextStyle urbanistSemiBold({required Color color, required, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: AppFonts.Urbanist,
    fontWeight: FontWeight.w600
  );
}


TextStyle urbanistBold({required Color color, required, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: AppFonts.Urbanist,
    fontWeight: FontWeight.bold
  );
}
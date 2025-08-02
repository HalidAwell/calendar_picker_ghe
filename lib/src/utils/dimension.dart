import 'package:flutter/material.dart';

class Dimen {
  // for Alertblock
  static const double dialogWidthSmall = 200.0;
  static const double dialogWidthLarge = 250.0;
  // for padding and spacing
  static const double spacingSmall = 1.0;
  static const double spacingMedium = 5.0;
  static const double spacingLarge = 10.0;

  //Table cell height
  static const double cellSmall = 25;
  static const double cellMedium = 28;

  //Font size
  static const double fSmall = 10;
  static const double fMedium = 11;
  static const double fBig = 12;

  static bool isSmall(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width <= 460;
  }
}

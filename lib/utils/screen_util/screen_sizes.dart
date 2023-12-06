import 'package:flutter/material.dart';

class ScreenSizes {
  static double? screenHeight;
  static double? screenWidth;

  void initScreenConstants(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}

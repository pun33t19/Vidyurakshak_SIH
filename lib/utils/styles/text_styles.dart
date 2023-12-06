import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class TextStyles {
  static TextStyle largeHeaderText = GoogleFonts.lato(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: AppColors.primaryTextColor);
  static TextStyle ts400m = GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryTextColor);
  static TextStyle ts400s = GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryTextColor);
}

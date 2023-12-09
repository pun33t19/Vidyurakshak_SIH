import 'package:flutter/material.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: AppColors.primaryTextColor)),
    primaryColor: const Color(0xFF3c8031),
  );
}

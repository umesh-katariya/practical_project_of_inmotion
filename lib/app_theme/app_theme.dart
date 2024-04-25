import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'app_colors.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  colorScheme: const ColorScheme.highContrastLight(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondary,
    onPrimary: AppColors.primaryColor,
    surface: AppColors.primaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor:AppColors.primaryColor)),
  textTheme: const TextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    iconTheme: IconThemeData(color: AppColors.black),
    elevation: 0,
  ),
);

import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';

class MAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: MColors.primary,
    scaffoldBackgroundColor: MColors.bgLight,
    appBarTheme: AppBarTheme(backgroundColor: MColors.bgLight),
    colorScheme: ColorScheme.light(
      surface: MColors.bgLight,
      onSurface: MColors.black,
      primary: MColors.primary,
      secondary: MColors.secondary,
      tertiary: MColors.tertiary,
      outline: Colors.grey.shade400,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: MColors.primary,
    scaffoldBackgroundColor: MColors.bgDark,
    appBarTheme: AppBarTheme(backgroundColor: MColors.bgDark),
    colorScheme: ColorScheme.dark(
      surface: MColors.bgDark,
      onSurface: MColors.white,
      primary: MColors.primary,
      secondary: MColors.secondary,
      tertiary: MColors.tertiary,
    ),
  );
}

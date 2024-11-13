import 'package:flutter/material.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:detect_fakes/utils/theme/widget_themes/appbar_theme.dart';
import 'package:detect_fakes/utils/theme/widget_themes/elevbutton_theme.dart';
import 'package:detect_fakes/utils/theme/widget_themes/outlinbutton_theme.dart';
import 'package:detect_fakes/utils/theme/widget_themes/txtformfield_theme.dart';
import 'package:detect_fakes/utils/theme/widget_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.lightTextTheme,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: DFAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    floatingActionButtonTheme: fabTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.darkTextTheme,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: DFAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    floatingActionButtonTheme: fabTheme,
  );

  static FloatingActionButtonThemeData fabTheme =
      const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.light,
    elevation: 5.0,
  );
}

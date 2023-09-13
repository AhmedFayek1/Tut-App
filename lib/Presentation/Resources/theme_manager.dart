import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tut_app/Presentation/Resources/style_manager.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getThemeData() {
  return ThemeData(
    //main color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.lightGrey,

    //cardview theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSizes.s4,
    ),

    //Appbar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      elevation: AppSizes.s4,
      centerTitle: true,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: regularText(
        fontSize: AppSizes.s16,
        color: ColorManager.white,
      ),
    ),

    //Button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.lightGrey,
      splashColor: ColorManager.lightPrimary,
    ),

    //Elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.lightPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
        elevation: AppSizes.s4,
        shadowColor: ColorManager.lightPrimary,
        textStyle: regularText(
          fontSize: FontSizes.s17,
          color: ColorManager.white,
        ),
      ),
    ),

    //Text theme
    textTheme: TextTheme(
        displayLarge: semiBoldText(
          fontSize: FontSizes.s16,
          color: ColorManager.grey,
        ),
        headlineMedium: regularText(
          fontSize: FontSizes.s14,
          color: ColorManager.darkGrey,
        ),
        titleSmall: mediumText(
          fontSize: FontSizes.s14,
          color: ColorManager.lightPrimary,
        ),
        labelLarge: regularText(
          color: ColorManager.grey,
        ),
        bodyLarge: regularText(
          color: ColorManager.darkGrey,
        ),
        labelSmall:
            boldText(color: ColorManager.primary, fontSize: AppSizes.s12)),

    //Input theme Text Form Field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      //Label Text Style
      labelStyle: regularText(
        color: ColorManager.grey,
        fontSize: FontSizes.s14,
      ),

      //Hint Text Style
      hintStyle: mediumText(
        color: ColorManager.grey,
        fontSize: FontSizes.s14,
      ),

      //Error Text Style
      errorStyle: regularText(
        color: ColorManager.error,
        fontSize: FontSizes.s14,
      ),

      //Border Style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: AppSizes.s1,
        ),
      ),

      //Enabled Border Style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        borderSide: const BorderSide(
          color: ColorManager.grey,
          width: AppSizes.s1,
        ),
      ),

      //Error Border Style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSizes.s1,
        ),
      ),

      //Focused Error Border Style
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: AppSizes.s1,
        ),
      ),
    ),
  );
}

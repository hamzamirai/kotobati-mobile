/*
* Created By Mirai Devs.
* On 06/22/2023.
*/

import 'package:flutter/material.dart';

import 'app_theme_text.dart';

abstract class AppTheme {
  static const Color keyAppColor = Color(0xFFF65656);
  static const Color keyAppColorDark = Color(0xFFD43A3A);
  static const Color keyAppBlackColor = Color(0xFF0C0B0B);
  static const Color keyAppGrayColor = Color(0xFFA1A1A1);
  static const Color keyAppGrayColorDark = Color(0xFF707070);
  static const Color keyAppWhiteColor = Color(0xFFFFFFFF);

  final Color highlightColor = keyAppColor.withOpacity(0.8);

  static Duration shimmerDuration = const Duration(milliseconds: 1200);

  /// ThemeData
  static ThemeData get themeData => ThemeData(
        backgroundColor: keyAppColor,
        fontFamily: 'UniviaPro',
        appBarTheme: const AppBarTheme(color: keyAppColor),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: keyAppColor,
        cardColor: keyAppBlackColor,
        highlightColor: keyAppColor.withOpacity(.2),
        splashColor: keyAppColor.withOpacity(.2),
        textTheme: AppTextTheme.textTheme(),
      );

  final OutlineInputBorder outlineInputBorderForTextField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(
      color: keyAppGrayColorDark,
      width: 2,
    ),
  );

  static OutlineInputBorder miraiOutlineInputBorderForTextField({
    Color? color,
    double? borderRadius,
    double? borderWidth,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 28),
      borderSide: BorderSide(
        width: borderWidth ?? 2,
        color: color ?? keyAppGrayColorDark,
      ),
    );
  }

  static UnderlineInputBorder miraiUnderlineInputBorder({
    Color? color,
    double? borderRadius,
    double? borderWidth,
  }) {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 28),
      borderSide: BorderSide(
        width: borderWidth ?? 2,
        color: color ?? keyAppGrayColorDark,
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData();

Color greyColor = const Color(0xFFEAEAEA);

Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100, 'Percent must be b/w 1&100');
  final f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}

Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100, 'Percent must be b/w 1&100');
  final p = percent / 100;
  return Color.fromARGB(
    c.alpha,
    c.red + ((255 - c.red) * p).round(),
    c.green + ((255 - c.green) * p).round(),
    c.blue + ((255 - c.blue) * p).round(),
  );
}

ThemeData blackTheme(Color primaryColor, Color accentColor) =>
    ThemeData.dark().copyWith(
      snackBarTheme: SnackBarThemeData(
        backgroundColor: accentColor,
        actionTextColor: greyColor,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
      colorScheme:
          ColorScheme.dark(secondary: accentColor, primary: primaryColor),
      cardColor: Colors.black,
      brightness: Brightness.dark,
      primaryColorLight: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      dialogBackgroundColor: Colors.black,
      canvasColor: Colors.black,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionHandleColor: primaryColor,
        selectionColor: darken(primaryColor, 50),
      ),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headline5: TextStyle(color: Colors.white),
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        caption: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }
              return primaryColor;
            },
          ),
          /* elevation: MaterialStateProperty.resolveWith<double>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return 0;
            }
            return 0;
          },
        ),*/
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }
              return primaryColor;
            },
          ),
        ),
      ),
      iconTheme: const IconThemeData().copyWith(color: Colors.white),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.black,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }
              return Colors.white;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }
              return Colors.black;
            },
          ),
        ),
      ),
    );

ThemeData lightTheme(Color primaryColor, Color accentColor) =>
    ThemeData.light().copyWith(
      canvasColor: Colors.white,
      cardColor: const Color.fromARGB(255, 255, 255, 255),
      appBarTheme: AppBarTheme(
          color: primaryColor, elevation: 0, foregroundColor: Colors.white),
      colorScheme:
          ColorScheme.light(secondary: accentColor, primary: primaryColor),
      toggleableActiveColor: primaryColor,
      primaryColor: primaryColor,
      dialogTheme: const DialogTheme(
          titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      )),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: accentColor,
        actionTextColor: Colors.white,
        contentTextStyle: const TextStyle(
          color: Colors.white,
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
      brightness: Brightness.light,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: const IconThemeData().copyWith(color: Colors.black),
      textTheme: TextTheme(
        headline5: const TextStyle(color: Colors.black),
        headline1: const TextStyle(color: Colors.black),
        headline2: const TextStyle(color: Colors.black),
        bodyText1: const TextStyle(color: Colors.black),
        bodyText2: const TextStyle(color: Colors.black),
        caption: const TextStyle(color: Colors.black),
        subtitle1: const TextStyle(color: Colors.black),
        subtitle2: TextStyle(color: Colors.grey[200]),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionHandleColor: primaryColor,
        selectionColor: lighten(primaryColor, 65),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }
              return primaryColor;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.black;
              }
              return primaryColor;
            },
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }
              return primaryColor;
            },
          ),
        ),
      ),
    );

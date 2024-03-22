import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      splashFactory: NoSplash.splashFactory,
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      ),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      side: MaterialStateProperty.all(
        const BorderSide(color: Colors.black),
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
  ),
);

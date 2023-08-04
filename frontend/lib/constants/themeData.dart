import 'package:flutter/material.dart';

ThemeData mycustomtheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.black,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black))),
  inputDecorationTheme: InputDecorationTheme(
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
      prefixIconColor: Colors.grey,
      focusColor: Colors.grey,
      suffixIconColor: Colors.grey),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black)),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    side: BorderSide(width: 2),
    foregroundColor: Colors.black,
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  )),
);

OutlineInputBorder outlineInputBorder =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

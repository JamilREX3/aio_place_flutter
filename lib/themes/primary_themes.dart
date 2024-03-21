import 'package:flutter/material.dart';

final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  primaryColor: Colors.indigoAccent,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade100,
    selectedItemColor: Colors.indigo,
    unselectedItemColor: Colors.grey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.indigo[100]),
      foregroundColor: MaterialStateProperty.all(Colors.indigo[900]),
    ),
  ),
  useMaterial3: true,
);

final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  primaryColor: Colors.indigo,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.indigoAccent.shade100,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.shifting,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
      foregroundColor: MaterialStateProperty.all(Colors.indigo[100]),
    ),
  ),
  useMaterial3: true,
);

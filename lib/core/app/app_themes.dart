import 'package:flutter/material.dart';

const Color _primaryColor = Color(0xffCC0000);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: _primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    secondary: Color.fromARGB(255, 50, 50, 50),
    primaryContainer: Color(0xffE2E2E2),
    secondaryContainer: Color(0xffF4F4F4),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: const CircleBorder(),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: Colors.transparent);
      }
      return const BorderSide(color: Colors.black, width: 1);
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _primaryColor; // #CC0000 red when checked
      }
      return Colors.transparent; // Transparent when unchecked
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  primaryColor: _primaryColor,
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    secondary: Color.fromARGB(255, 206, 206, 206),
    primaryContainer: Color.fromARGB(255, 50, 50, 50),
    secondaryContainer: Color(0xff282828),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: const CircleBorder(),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: Colors.transparent);
      }
      return const BorderSide(color: Colors.white, width: 1);
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _primaryColor; // #CC0000 red when checked
      }
      return Colors.transparent; // Transparent when unchecked
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
  ),
);

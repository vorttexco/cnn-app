import 'package:flutter/material.dart';

const Color _primaryColor = Color(0xffC00000);
const String _fontFamily = 'CNN Sans Display W04 Medium';

ThemeData lightTheme = ThemeData(
  fontFamily: _fontFamily,
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
    tertiary: Color.fromARGB(255, 75, 75, 75),
    primaryContainer: Color(0xffE2E2E2),
    secondaryContainer: Color(0xffF4F4F4),
    tertiaryContainer: Color(0xFFE6E6E6)
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
        return _primaryColor; // #C00000 red when checked
      }
      return Colors.transparent; // Transparent when unchecked
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontFamily: _fontFamily
    )
  )
);

ThemeData darkTheme = ThemeData(
  fontFamily: _fontFamily,
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xff181A1B),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff181A1B),
  ),
  primaryColor: _primaryColor,
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    secondary: Color.fromARGB(255, 206, 206, 206),
    tertiary: Color(0xff8C8C8C),
    primaryContainer: Color.fromARGB(255, 50, 50, 50),
    secondaryContainer: Color(0xff181a1b),
    tertiaryContainer: Color(0xFFE6E6E6)
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
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontFamily: _fontFamily
    )
  )
);

import 'package:cnn_brasil_app/core/app/app_constants.dart';
import 'package:cnn_brasil_app/core/managers/storage_manager.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeProvider(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(ThemeMode newMode) {
    _themeMode = newMode;

    notifyListeners();

    StorageManager().setString(
      AppConstants.SHARED_PREFERENCES_THEME_MODE,
      _themeMode.toString(),
    );
  }
}

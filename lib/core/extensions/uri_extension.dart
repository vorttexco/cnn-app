import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension UriWithParams on Uri {
  Future<Uri> withThemeQuery(BuildContext context) async {
    String theme = await StorageManager()
            .getString(AppConstants.SHARED_PREFERENCES_THEME_MODE) ??
        '';

    bool isDark = false;
    if (theme == ThemeMode.dark.toString()) {
      isDark = true;
    } else if (theme == ThemeMode.system.toString()) {
      var brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      isDark = brightness == Brightness.dark;
    }

    if (queryParameters.isEmpty) {
      return replace(query: 'darkMode=${isDark ? 1 : 0}');
    } else {
      Map<String, String> newQueryParams = Map.from(queryParameters);
      newQueryParams['darkMode'] = '${isDark ? 1 : 0}';
      return replace(queryParameters: newQueryParams);
    }
  }
}

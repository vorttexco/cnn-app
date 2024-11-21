import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

extension UriWithParams on WebUri {
  Future<WebUri> withThemeQuery(BuildContext context) async {
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

    Map<String, String> newQueryParams = Map.from(queryParameters);
    newQueryParams['darkmode'] = isDark ? 'true' : 'false';
    return WebUri.uri(replace(queryParameters: newQueryParams));
  }
}

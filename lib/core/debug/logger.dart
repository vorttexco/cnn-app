import 'package:flutter/foundation.dart';

import '../app/app_label.dart';

class Logger {
  static log(String? message, {int? wrapWidth, String? tag}) {
    if (kDebugMode) {
      final print =
          '${AppLabel.appName}::${tag == null ? '' : '[$tag]'} $message';
      debugPrint(print, wrapWidth: wrapWidth);
    }
  }
}

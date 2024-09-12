// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConstants {
  Size screenSize = const Size(0, 0);
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  static String appVersion = '';

  static const KPADDING_24 = 24.0;
  static const KPADDING_16 = 16.0;
  static const KPADDING_8 = 8.0;
  static const KPADDING_4 = 4.0;

  static const KPADDING_DEFAULT = KPADDING_16;

  static const KFONTSIZE_12 = 12.0;
  static const KFONTSIZE_14 = 14.0;
  static const KFONTSIZE_16 = 16.0;
  static const KFONTSIZE_18 = 18.0;
  static const KFONTSIZE_20 = 20.0;
  static const KFONTSIZE_24 = 24.0;

  static const String SHARED_PREFERENCES_SAVE_USER =
      'SHARED_PREFERENCES_SAVE_USER';

  static const String SHARED_PREFERENCES_THEME_MODE =
      'SHARED_PREFERENCES_THEME_MODE';

  static const String SHARED_PREFERENCES_NOTIFICATIONS_SETTINGS =
      'SHARED_PREFERENCES_NOTIFICATIONS_SETTINGS';

  static const String SHARED_PREFERENCES_VIEW_NOTIFICATIONS_SETTINGS =
      'SHARED_PREFERENCES_VIEW_NOTIFICATIONS_SETTINGS';

  static const _ONESIGNAL_PRO_KEY = '25d68d0c-ab94-4b2a-93bd-1e9dc3318e58';
  static const _ONESIGNAL_DEV_KEY = 'e59bb0fc-f8ee-4eb9-90d6-c74de78232f0';
  static const ONESIGNAL_KEY =
      kReleaseMode ? _ONESIGNAL_PRO_KEY : _ONESIGNAL_DEV_KEY;

  static const GOOGLE_CLIENT_IOS =
      '259226150264-6io68qvfkq3o1i1olcp6euoanvkqjult.apps.googleusercontent.com';
  static const GOOGLE_CLIENT_ANDROID =
      '259226150264-05h2krjig2oa4qkm7ivjb8plrivd04qq.apps.googleusercontent.com';
  static const DEEPPLINK_AO_VIVO = 'https://www.cnnbrasil.com.br/ao-vivo';

  static const MENU_LOGOUT_ID = -9999;

  static const TOTAL_PLAYLIST_FULL = 15;
  static const TOTAL_PLAYLIST_MINIMAL = 4;
}

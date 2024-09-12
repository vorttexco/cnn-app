import 'package:cnn_brasil_app/features/notifications_settings/notifications_settings.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SplashViewModel extends State<Splash> {
  @override
  void initState() {
    super.initState();

    _checkAndStart();
  }

  _checkAndStart() async {
    var viewNotificationValue = await StorageManager()
        .getBool(AppConstants.SHARED_PREFERENCES_VIEW_NOTIFICATIONS_SETTINGS);

    await Future.delayed(const Duration(seconds: 3));

    if (viewNotificationValue == null) {
      await Navigator.pushNamed(context, NotificationsSettings.route);
      await StorageManager().setBool(
        AppConstants.SHARED_PREFERENCES_VIEW_NOTIFICATIONS_SETTINGS,
        true,
      );
    }

    NavigatorManager(context).replacement(TabNavigator.route);
  }
}

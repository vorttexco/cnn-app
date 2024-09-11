import 'package:cnn_brasil_app/features/notifications_settings/notifications_settings.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class NotificationsSettingsViewModel
    extends State<NotificationsSettings> {
  final Map<String, bool> notificationOptions = {
    'Política': true,
    'Economia': true,
    'Esportes': true,
    'POP': true,
    'Viagem e Gastronomia': true,
    'Nacional': true,
    'Internacional': true,
    'Saúde': true,
    'Tecnologia': true,
    'Lifestyle': true,
  };
  bool updatedPreferences = false;
  @override
  void initState() {
    super.initState();

    _getOptions();
  }

  void _getOptions() async {
    context.loaderOverlay.show();

    for (var item in notificationOptions.entries) {
      final value = await StorageManager().getBool(
        AppConstants.SHARED_PREFERENCES_NOTIFICATIONS_SETTINGS + item.key,
      );

      notificationOptions[item.key] = value ?? true;
    }

    setState(() {
      notificationOptions;
      updatedPreferences = true;
    });
    context.loaderOverlay.hide();
  }

  void onSavePreferences() async {
    context.loaderOverlay.show();

    try {
      await OneSignal.User.addTags(
        notificationOptions.map(
          (key, value) => MapEntry(
            key,
            value.toString(),
          ),
        ),
      );

      for (var item in notificationOptions.entries) {
        await StorageManager().setBool(
          AppConstants.SHARED_PREFERENCES_NOTIFICATIONS_SETTINGS + item.key,
          item.value,
        );
      }
    } on Exception {
      //
    }

    context.loaderOverlay.hide();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

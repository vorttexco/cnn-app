import 'package:cnn_brasil_app/features/notifications_settings/notifications_settings.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';

abstract class NotificationsSettingsViewModel
    extends State<NotificationsSettings> {
  final Map<String, bool> notificationOptions = {};
  final Map<String, bool> _tagOptions = {};
  bool updatedPreferences = false;
  @override
  void initState() {
    super.initState();

    _getOptions();
  }

  void _getOptions() async {
    context.loaderOverlay.show();

    var options = await HomeRepository(ApiConnector()).menuHome();

    for (var item in options) {
      if (item.title == null) continue;

      _tagOptions[item.title!] = item.segmentedPush ?? false;

      if (item.segmentedPush != null && item.segmentedPush == true) {
        final value = await StorageManager().getBool(
          AppConstants.SHARED_PREFERENCES_NOTIFICATIONS_SETTINGS + item.title!,
        );

        notificationOptions[item.title!] = value ?? true;
      }
    }

    setState(() {
      notificationOptions;
      updatedPreferences = true;
    });

    context.loaderOverlay.hide();
  }

  void onSavePreferences() async {
    context.loaderOverlay.show();

    final saveOptions = Map.from(notificationOptions);

    saveOptions.addEntries(_tagOptions.entries
        .where((entry) => !notificationOptions.containsKey(entry.key)));

    try {
      await OneSignal.User.addTags(
        saveOptions.map(
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

import 'package:cnn_brasil_app/features/notifications_settings/notifications_settings.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';

abstract class NotificationsSettingsViewModel
    extends State<NotificationsSettings> {
  final Map<String, bool> notificationOptions = {};
  bool updatedPreferences = false;
  @override
  void initState() {
    super.initState();

    _getOptions();
  }

  void _getOptions() async {
    context.loaderOverlay.show();

    final options = await HomeRepository(ApiConnector()).menuHome();
    final tags = await OneSignal.User.getTags();

    for (var item in options) {
      if (item.title == null) continue;

      if (item.segmentedPush != null && item.segmentedPush == true) {
        final bool value = bool.tryParse(tags[item.title!] ?? '') ?? false;

        notificationOptions[item.title!] = value;
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

    try {
      await OneSignal.User.addTags(
        notificationOptions.map(
          (key, value) => MapEntry(
            key,
            value.toString(),
          ),
        ),
      );
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

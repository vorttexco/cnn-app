import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class NavigatorManager {
  final BuildContext context;

  NavigatorManager(this.context);

  void logScreenFirebase(NavigatorAnalytics analytics) {
    try {
      FirebaseAnalytics.instance.logScreenView(
        screenClass: analytics.firebaseScreenClass,
        screenName: analytics.firebaseScreen,
        parameters: {
          'firebase_screen': analytics.firebaseScreen,
          'firebase_screen_class': analytics.firebaseScreenClass,
          'firebase_screen_id': analytics.firebaseScreenId ?? '',
          'firebase_previous_screen': analytics.firebasePreviousScreen ?? '',
          'firebase_previous_class': analytics.firebasePreviousClass ?? '',
          'firebase_previous_id': analytics.firebasePreviousId ?? '',
          'engagement_time_msec': analytics.engagementTimeMsec ?? '',
          'page_author_1': analytics.pageAuthor ?? '',
          'page_publication_date': analytics.pagePublicationDate ?? '',
          'page_category': analytics.pageCategory ?? '',
        },
      );
    } on Exception {
      //Could not call firebase
    }
  }

  void logArticleScreenFirebase(String currentRoute, ) {}

  void to(
    String route, {
    dynamic data,
    Function? onFinished,
    required String currentScreen,
    String? currentScreenClass,
    String? currentScreenId,
    fullscreen = false,
    bool rootNavigator = true,
    NavigatorAnalytics? analytics,
  }) async {
    if (route != "/Article/") {
      logScreenFirebase(
        analytics ?? NavigatorAnalytics.fromRoute(route, context),
      );
    }

    if (route == "/Article/" && currentScreenClass == null && currentScreenId == null) {
      var routeName = getbyRouteName(currentScreen);

      await StorageManager().setString("firebase_previous_screen", routeName);
      await StorageManager().setString("firebase_previous_class", currentScreen);
      await StorageManager().setString("firebase_previous_id", currentScreen);
    } else if (route == "/Article/" && currentScreenClass != null && currentScreenId != null) {
      await StorageManager().setString("firebase_previous_screen", currentScreen);
      await StorageManager().setString("firebase_previous_class", currentScreenClass);
      await StorageManager().setString("firebase_previous_id", currentScreenId);
    }

    OneSignal.Session.addOutcome('screen-view:$route');

    Navigator.of(context, rootNavigator: rootNavigator)
        .pushNamed(
      route,
      arguments: data,
    )
        .then((value) {
      onFinished?.call();
    });
  }

  void modal(Widget widget,
      {dynamic data, Function? onFinished, fullscreenDialog = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
        settings: RouteSettings(arguments: data),
      ),
    ).then((value) {
      onFinished?.call();
    });
  }

  void replacement(String route,
          {dynamic data,
          VoidCallback? onFinished,
          bool rootNavigator = true}) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushReplacementNamed(route, arguments: data)
          .then((value) {
        onFinished?.call();
      });

  Future<void> fullModal(Widget child,
      {Widget? header, VoidCallback? onFinished}) {
    Provider.of<FullscreenProvider>(context, listen: false).setFullScreen(true);
    return showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      scrollControlDisabledMaxHeightRatio: 1,
      builder: (context) => Material(
        child: Column(
          children: [
            header ??
                Container(
                  width: double.infinity,
                  height: 110,
                  color: Colors.white,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )),
                ),
            Expanded(child: child),
          ],
        ),
      ),
    ).then((_) {
      Provider.of<FullscreenProvider>(context, listen: false)
          .setFullScreen(false);
      onFinished?.call();
    });
  }

  void modalVideo(Widget child) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.7),
      isScrollControlled: true,
      builder: (context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: child,
        ),
      ),
    );
  }

  void back() => Navigator.of(context).pop();
}

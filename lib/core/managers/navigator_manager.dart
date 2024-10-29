import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class NavigatorManager {
  final BuildContext context;

  NavigatorManager(this.context);

  void to(
    String route, {
    dynamic data,
    Function? onFinished,
    fullscreen = false,
    bool rootNavigator = true,
    NavigatorAnalytics? analytics,
  }) {
    if (analytics != null) {
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
    } else {
      final analyticsRoute = NavigatorAnalytics.fromRoute(route, context);
      FirebaseAnalytics.instance.logScreenView(
        screenClass: analyticsRoute.firebaseScreenClass,
        screenName: analyticsRoute.firebaseScreen,
        parameters: {
          'firebase_screen': analyticsRoute.firebaseScreen,
          'firebase_screen_class': analyticsRoute.firebaseScreenClass,
          'firebase_screen_id': analyticsRoute.firebaseScreenId ?? '',
          'firebase_previous_screen':
              analyticsRoute.firebasePreviousScreen ?? '',
          'firebase_previous_class': analyticsRoute.firebasePreviousClass ?? '',
          'firebase_previous_id': analyticsRoute.firebasePreviousId ?? '',
          'engagement_time_msec': analyticsRoute.engagementTimeMsec ?? '',
          'page_author_1': analyticsRoute.pageAuthor ?? '',
          'page_publication_date': analyticsRoute.pagePublicationDate ?? '',
          'page_category': analyticsRoute.pageCategory ?? '',
        },
      );
    }

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

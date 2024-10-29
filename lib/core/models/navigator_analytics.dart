import 'package:cnn_brasil_app/features/blogs/blogs.dart';
import 'package:cnn_brasil_app/features/custom_webview/custom_webview.dart';
import 'package:cnn_brasil_app/features/home/home.dart';
import 'package:cnn_brasil_app/features/live_stream/live_stream.dart';
import 'package:cnn_brasil_app/features/notifications_settings/notifications_settings.dart';
import 'package:cnn_brasil_app/features/search/search.dart';
import 'package:cnn_brasil_app/features/section_view_detail/section_view_detail.dart';
import 'package:cnn_brasil_app/features/stories/stories.dart';
import 'package:cnn_brasil_app/features/submenu/submenu.dart';
import 'package:cnn_brasil_app/features/tab_navigator/tab_navigator.dart';
import 'package:cnn_brasil_app/features/themes/themes.dart';
import 'package:flutter/material.dart';

class NavigatorAnalytics {
  final String firebaseScreen, firebaseScreenClass;

  final String? firebaseScreenId,
      firebasePreviousScreen,
      firebasePreviousClass,
      firebasePreviousId,
      engagementTimeMsec,
      pageAuthor,
      pagePublicationDate,
      pageCategory;

  NavigatorAnalytics({
    required this.firebaseScreen,
    required this.firebaseScreenClass,
    this.firebaseScreenId,
    this.firebasePreviousScreen,
    this.firebasePreviousClass,
    this.firebasePreviousId,
    this.engagementTimeMsec,
    this.pageAuthor,
    this.pagePublicationDate,
    this.pageCategory,
  });

  factory NavigatorAnalytics.fromRoute(String route, BuildContext context) {
    String getbyRouteName(String name) {
      switch (route) {
      case TabNavigator.route:
        return '';
      case Home.route:
        return 'Home Screen';
      case LiveStream.route:
        return 'Live Stream';
      case Blogs.route:
        return 'Blogs';
      case Stories.route:
        return 'Stories';
      case Search.route:
        return 'Search Screen';
      case Themes.route:
        return 'Temas do App';
      case NotificationsSettings.route:
        return 'Configurações de Notificações';
      case SectionViewDetail.route:
        return 'Detalhes de Seções';
      case Submenu.route:
        return 'SubMenu';
      case CustomWebView.route:
        return 'WebView Customizado';
      default:
        return 'Erro de Rota';
    }
    }
    late String screenName;

    Navigator.of(context).

    return NavigatorAnalytics(
      firebaseScreen: screenName,
      firebaseScreenClass: route,
    );
  }

  factory NavigatorAnalytics.fromUrl(String url) {
    final Uri uri = Uri.parse(url);
    final segments = uri.pathSegments;

    return NavigatorAnalytics(
      firebaseScreen: segments.isNotEmpty ? segments.last : '',
      firebaseScreenClass: url,
      firebasePreviousId: segments.isNotEmpty ? segments.last : null,
    );
  }
}

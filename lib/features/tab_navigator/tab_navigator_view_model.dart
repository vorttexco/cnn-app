import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import '../index.dart';

abstract class TabNavigatorViewModel extends State<TabNavigator> {
  final List<Widget> pages = [
    const Home(),
    const LiveStream(),
    const Blogs(),
    const Stories(),
    const Search(),
  ];

  void onTabTapped(int index) {
    if (index == 0) {
      Provider.of<TabbarProvider>(context, listen: false).setReloadHome(true);
    }
    Provider.of<TabbarProvider>(context, listen: false).setTabIndex(index);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        loadUser();
      },
    );
  }

  loadUser() async {
    try {
      final userModel = await UserRepository(ApiConnector()).get(null);
      AppManager.setUser(userModel);
    } on Exception catch (e) {
      Logger.log(e.toString());
    }

    try {
      OneSignal.Notifications.addClickListener((event) {
        onReceivedPushNotification(event);
      });
    } on Exception catch (e) {
      Logger.log(e.toString());
    }
  }

  onReceivedPushNotification(OSNotificationClickEvent result) {
    try {
      if (result.notification.additionalData == null ||
          result.notification.additionalData!['app-url'] == null) {
        return;
      }

      String deeplink = result.notification.additionalData!['app-url'];

      if (deeplink.contains(AppConstants.DEEPPLINK_AO_VIVO)) {
        Future.delayed(const Duration(seconds: 1)).then(
          (value) {
            onTabTapped(1);
          },
        );
        return;
      }

      final url = '$deeplink?hidemenu=true';
      NavigatorManager(context).to(
        CustomWebView.route,
        data: WebviewNavigatorModel(title: 'Voltar', url: url),
        analytics: NavigatorAnalytics.fromUrl(url),
        currentScreen: TabNavigator.route
      );
    } on Exception catch (e) {
      Logger.log(e.toString());
    }
  }
}

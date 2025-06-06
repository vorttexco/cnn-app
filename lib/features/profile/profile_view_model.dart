import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class ProfileViewModel extends State<Profile>
    with WidgetsBindingObserver {
  final userRepository = UserRepository(ApiConnector());
  bool hasPermission = false;
  List<CnnMenuModel> listOfMenu = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadView();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.resumed == state) {
      hasPermission = OneSignal.Notifications.permission;
      setState(() {});
    }
  }

  Future<void> loadView() async {
    try {
      context.loaderOverlay.show();
      hasPermission = OneSignal.Notifications.permission;
      listOfMenu = await HomeRepository(ApiConnector()).menuCopyright();
    } finally {
      context.loaderOverlay.hide();
      setState(() {});
    }
  }

  void onTapPermissionRequest(bool value) {
    if (!OneSignal.Notifications.permission) {
      OneSignal.Notifications.requestPermission(value);
      hasPermission = OneSignal.Notifications.permission;
      setState(() {});
    }
  }

  openLink(CnnMenuModel menu) async {
    if (AppConstants.MENU_LOGOUT_ID == menu.id) {
      await userRepository.logout();
      AppManager.setUser(null);
      loadView();
      return;
    }

    NavigatorManager(context).to(
      CustomWebView.route,
      data: WebviewNavigatorModel(
          url: '${menu.url}?hidemenu=true',
          title: menu.title ?? AppLabel.appName),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class ProfileViewModel extends State<Profile>
    with WidgetsBindingObserver {
  final userRepository = UserRepository(ApiConnector());
  bool hasPermission = false;
  List<CnnMenuModel> listOfMenu = [];

  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: Platform.isIOS
        ? AppConstants.GOOGLE_CLIENT_IOS
        : AppConstants.GOOGLE_CLIENT_ANDROID,
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
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
      if (AppManager.user != null) {
        listOfMenu.add(
          CnnMenuModel(title: 'Logout', id: AppConstants.MENU_LOGOUT_ID),
        );
      }
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

  Future<void> login() async {
    try {
      final googleResponse = await googleSignIn.signIn();
      final authentication = await googleResponse?.authentication;

      context.loaderOverlay.show();

      final user = UserModel(
        token: authentication?.idToken,
        device: Platform.isIOS ? 'ios' : 'android',
      );

      final request = await userRepository.create(user);
      if (request.success) {
        final userModel = UserModel.fromJson(request.data);
        OneSignal.login(userModel.ppid ?? '');
        AppManager.setUser(userModel);
        await userRepository.save(userModel);
        loadView();
        return;
      }

      CustomAlertView(context).show(
        request.message ?? 'Não foi possível realizar seu login',
      );
    } catch (error) {
      CustomAlertView(context).show(
        'Não foi possível realizar seu login',
      );
      Logger.log(error.toString());
    } finally {
      context.loaderOverlay.hide();
      setState(() {});
    }
  }
}

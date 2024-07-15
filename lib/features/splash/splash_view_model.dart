import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SplashViewModel extends State<Splash> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        NavigatorManager(context).replacement(TabNavigator.route);
      },
    );
  }
}

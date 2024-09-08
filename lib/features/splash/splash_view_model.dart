import 'package:flutter/material.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SplashViewModel extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        NavigatorManager(context).replacement(TabNavigator.route);
      },
    );
  }
}

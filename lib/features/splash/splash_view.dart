import '../../core/app/index.dart';
import 'package:flutter/material.dart';
import './splash_view_model.dart';

class SplashView extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
          child: Image.asset(
        'assets/images/logo_splash_wihite.png',
        width: 192,
        height: 90,
        fit: BoxFit.fitWidth,
      )),
    );
  }
}

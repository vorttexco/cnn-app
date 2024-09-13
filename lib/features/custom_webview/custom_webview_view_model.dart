// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/index.dart';
import './custom_webview.dart';

abstract class CustomWebviewViewModel extends State<CustomWebView> {
  late InAppWebViewController controller;
  String currentUrl = '';

  @override
  void initState() {
    super.initState();
    currentUrl = widget.navigatorModel.url;
  }

  onBack() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return;
    }
    NavigatorManager(context).back();
  }

  onShare() {
    final url = currentUrl.replaceAll('?hidemenu=true', '');
    Share.share(url, subject: 'CNN Brasil');
  }
}

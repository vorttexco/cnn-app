// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import './custom_webview.dart';

abstract class CustomWebviewViewModel extends State<CustomWebView> {
  final controller = WebViewController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.enableZoom(false);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (WebResourceError error) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
    Logger.log(widget.navigatorModel.url);
    controller.loadRequest(Uri.parse(widget.navigatorModel.url));
  }

  onBack() async {
    if (await controller.canGoBack()) {
      isLoading = false;
      controller.goBack();
      return;
    }
    NavigatorManager(context).back();
  }
}

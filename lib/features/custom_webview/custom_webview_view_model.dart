// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import './custom_webview.dart';

abstract class CustomWebviewViewModel extends State<CustomWebView> {
  final controller = WebViewController();

  bool isLoading = true;
  String currentUrl = '';

  @override
  void initState() {
    super.initState();
    currentUrl = widget.navigatorModel.url;
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.enableZoom(false);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) {
          currentUrl = request.url;
          return NavigationDecision.navigate;
        },
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

  openWhatsApps(String url) {
    launchUrl(Uri.parse(url));
    try {} catch (e) {
      Logger.log(e.toString());
    }
  }

  onBack() async {
    if (await controller.canGoBack()) {
      isLoading = false;
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

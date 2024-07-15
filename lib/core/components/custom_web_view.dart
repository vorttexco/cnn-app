import '../app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewComponent extends StatelessWidget {
  final bool isLoading;
  final WebViewController webViewController;
  const CustomWebViewComponent(
      {super.key, required this.isLoading, required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ))
        : WebViewWidget(
            controller: webViewController,
          );
  }
}

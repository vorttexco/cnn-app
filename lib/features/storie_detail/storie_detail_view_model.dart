import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './storie_detail.dart';

abstract class StorieDetailViewModel extends State<StorieDetail> {
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
        onWebResourceError: (WebResourceError error) {},
      ),
    );

    controller.loadRequest(Uri.parse(widget.url));
  }

  void onBack() {
    Navigator.pop(context);
  }
}

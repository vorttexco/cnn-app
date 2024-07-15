import 'package:flutter/material.dart';

import '../../core/index.dart';
import './custom_webview_view_model.dart';

class CustomWebviewView extends CustomWebviewViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            AppBarInternal(
              onFinished: () {
                setState(() {});
              },
              title: widget.navigatorModel.title,
              onIconPressed: onBack,
              avatar: AppManager.user != null
                  ? Image.network(AppManager.user?.picture ?? '')
                  : null,
            ),
            Expanded(
              child: CustomWebViewComponent(
                webViewController: controller,
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cnn_brasil_app/core/components/app_bar_webview.dart';
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
            AppBarwebView(
              onFinished: () {
                setState(() {});
              },
              title: 'Voltar',
              onIconPressed: onBack,
              onShare: onShare,
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

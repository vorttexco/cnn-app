import '../../core/models/webview_navigator_model.dart';
import 'package:flutter/material.dart';
import './custom_webview_view.dart';

class CustomWebView extends StatefulWidget {
  static const route = '/CustomWebview/';
  final WebviewNavigatorModel navigatorModel;
  const CustomWebView({super.key, required this.navigatorModel});

  @override
  CustomWebviewView createState() => CustomWebviewView();
}

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import './storie_detail.dart';

abstract class StorieDetailViewModel extends State<StorieDetail> {
  late InAppWebViewController controller;

  void onBack() {
    Navigator.pop(context);
  }
}

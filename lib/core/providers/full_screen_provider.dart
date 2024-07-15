import 'package:flutter/material.dart';

class FullscreenProvider with ChangeNotifier {
  bool _isFullScreen = false;

  bool get isFullScreen => _isFullScreen;

  void setFullScreen(bool isFullScreen) {
    _isFullScreen = isFullScreen;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class TabbarProvider with ChangeNotifier {
  int _indexSelected = 0;
  int get indexSelected => _indexSelected;

  void setTabIndex(int value) {
    _indexSelected = value;
    notifyListeners();
  }

  bool _reloadHome = false;
  bool get reloadHome => _reloadHome;

  void setReloadHome(bool value) {
    _reloadHome = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SubmenuViewModel extends State<Submenu> {
  openMenu(CnnMenuModel? menu) {
    if (menu!.child!.isEmpty) {
      NavigatorManager(context).to(
        SectionViewDetail.route,
        data: menu,
      );
      return;
    }

    NavigatorManager(context)
        .to(Submenu.route, data: menu, rootNavigator: false);
  }

  onBack() {
    Logger.log('onback');
    Navigator.of(context).pop();
  }
}

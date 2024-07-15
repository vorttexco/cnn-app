// ignore_for_file: use_build_context_synchronously

import 'package:cnn_brasil_app/features/index.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';

abstract class HomeMenuViewModel extends State<HomeMenu> {
  List<CnnMenuModel> listOfMenu = [];

  @override
  void initState() {
    super.initState();

    loadView();
  }

  Future<void> loadView() async {
    try {
      context.loaderOverlay.show();
      listOfMenu = await HomeRepository(ApiConnector()).menuHome();
    } finally {
      context.loaderOverlay.hide();
      setState(() {});
    }
  }

  openMenu(CnnMenuModel menu) {
    if (menu.child!.isEmpty) {
      NavigatorManager(context).to(SectionViewDetail.route, data: menu);
      return;
    }

    NavigatorManager(context)
        .to(Submenu.route, data: menu, rootNavigator: false);
  }
}

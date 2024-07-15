import 'package:flutter/material.dart';

import '../../core/index.dart';
import './home_menu_view_model.dart';

class HomeMenuView extends HomeMenuViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final menu = listOfMenu[index];
          return InkWell(
            onTap: () => openMenu(menu),
            child: CellMenuView(menu: menu),
          );
        },
        itemCount: listOfMenu.length,
      ),
    );
  }
}

import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import './submenu_view.dart';

class Submenu extends StatefulWidget {
  static const route = '/Submenu/';
  final CnnMenuModel model;
  const Submenu({super.key, required this.model});

  @override
  SubmenuView createState() => SubmenuView();
}

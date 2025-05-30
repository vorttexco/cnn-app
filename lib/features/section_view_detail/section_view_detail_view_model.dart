import 'package:cnn_brasil_app/core/repositories/sections_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../core/index.dart';
import './section_view_detail.dart';

abstract class SectionViewDetailViewModel extends State<SectionViewDetail> {
  final sectionsRepository = SectionsRepository(ApiConnector());
  late InAppWebViewController controller;

  List<CnnMenuModel> listOfMenu = [];
  CnnMenuModel? menuSelected;

  @override
  void initState() {
    super.initState();

    _loadView();
  }

  Future<void> _loadView() async {
    try {
      listOfMenu = await sectionsRepository.submenu(widget.model.slug ?? '');
      if (listOfMenu.isNotEmpty) {
        menuSelected = listOfMenu.first;
      }
    } catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  onSelectedMenu(CnnMenuModel model) {
    setState(() {
      menuSelected = model;
    });
    controller.loadUrl(
      urlRequest: URLRequest(url: WebUri('${model.url}?hidemenu=true')),
    );
  }

  onBack() async {
    NavigatorManager(context).back();
  }
}

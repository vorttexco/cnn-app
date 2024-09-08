import 'package:cnn_brasil_app/core/extensions/uri_extension.dart';
import 'package:cnn_brasil_app/core/repositories/sections_repository.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import './section_view_detail.dart';

abstract class SectionViewDetailViewModel extends State<SectionViewDetail> {
  final sectionsRepository = SectionsRepository(ApiConnector());
  final controller = WebViewController();

  List<CnnMenuModel> listOfMenu = [];
  CnnMenuModel? menuSelected;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.enableZoom(false);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (WebResourceError error) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
    Logger.log(widget.model.url ?? '');

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _loadView();
      },
    );
  }

  Future<void> _loadView() async {
    try {
      controller.loadRequest(
          await Uri.parse('${widget.model.url}?hidemenu=true')
              .withThemeQuery(context));
    } catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }

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
    Uri.parse('${model.url}?hidemenu=true').withThemeQuery(context).then((uri) {
      controller.loadRequest(uri);
    });
  }

  onBack() async {
    NavigatorManager(context).back();
  }
}

import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class BlogsViewModel extends State<Blogs> {
  late InAppWebViewController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> navigateToInternalPage(String url) async {
    NavigatorManager(context).to(
      CustomWebView.route,
      data: WebviewNavigatorModel(url: url, title: 'Voltar'),
      onFinished: () {
        controller.goBack();
      },
      analytics: NavigatorAnalytics.fromUrl(url),
      currentScreen: Blogs.route
    );
  }

  void openMenu() {
    NavigatorManager(context).fullModal(
      const NestedNavigator(child: HomeMenu()),
      header: AppBarInternal(
        textAlign: TextAlign.center,
        icon: SvgPicture.asset(
          'assets/icons/close_menu.svg',
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title: 'Seções',
        onIconPressed: () {
          Navigator.of(context).pop(true);
          controller.reload();
        },
        avatar: AppManager.user != null
            ? Image.network(AppManager.user?.picture ?? '')
            : null,
      ),
    );
  }
}

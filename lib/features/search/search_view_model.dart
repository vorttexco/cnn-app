import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../core/firebase_analytics_manager.dart';
import '../../core/index.dart';
import '../index.dart';

abstract class SearchViewModel extends State<Search> {
  //
  late InAppWebViewController controller;
  final _debounce = Debounce();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        FirebaseAnalyticsManager.logScreen(screenName: 'busca');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _debounce.dispose();
  }

  void navigateToInternalPage(String url) {
    if (!url.contains('${ApiHome.home}/?s=') && url.contains(ApiHome.home)) {
      NavigatorManager(context).to(CustomWebView.route,
          data: WebviewNavigatorModel(url: url, title: 'Voltar'),
          onFinished: () {});
    }
  }

  void onSearch(String value) {
    _debounce(
      () {
        controller.loadUrl(
          urlRequest: URLRequest(
            url: WebUri(
                '${ApiHome.home}/?s=$value&orderby=date&order=desc&hidemenu=true'),
          ),
        );
      },
    );
  }

  void openMenu() {
    NavigatorManager(context).fullModal(
      const NestedNavigator(child: HomeMenu()),
      header: AppBarInternal(
        textAlign: TextAlign.center,
        icon: SvgPicture.asset('assets/icons/close_menu.svg'),
        title: 'Seções',
        onIconPressed: () {
          Navigator.of(context).pop(true);
        },
        avatar: AppManager.user != null
            ? Image.network(AppManager.user?.picture ?? '')
            : null,
      ),
    );
  }

  onTapLogo() {
    Provider.of<TabbarProvider>(context, listen: false).setTabIndex(0);
  }
}

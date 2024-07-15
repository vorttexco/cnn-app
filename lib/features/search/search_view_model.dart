import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SearchViewModel extends State<Search> {
  //
  final webViewController = WebViewController();
  final _debounce = Debounce();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(const Color(0x00000000));
    webViewController.enableZoom(false);

    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) {
          if (!request.url.contains('${ApiHome.home}/?s=') &&
              request.url.contains(ApiHome.home)) {
            navigateToInternalPage(request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _debounce.dispose();
  }

  void navigateToInternalPage(String url) {
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Voltar'),
        onFinished: () {});
  }

  void onSearch(String value) {
    _debounce(
      () {
        webViewController.loadRequest(
          Uri.parse(
              '${ApiHome.home}/?s=$value&orderby=date&order=desc&hidemenu=true'),
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

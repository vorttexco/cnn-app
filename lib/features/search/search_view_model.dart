import 'package:cnn_brasil_app/core/extensions/uri_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/firebase_analytics_manager.dart';
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
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Voltar'),
        onFinished: () {});
  }

  void onSearch(String value) {
    _debounce(
      () {
        Uri.parse(
                '${ApiHome.home}/?s=$value&orderby=date&order=desc&hidemenu=true')
            .withThemeQuery(context)
            .then((uri) {
          webViewController.loadRequest(uri);
        });
      },
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

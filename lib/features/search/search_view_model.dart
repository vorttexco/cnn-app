import 'package:cnn_brasil_app/core/extensions/weburi_extension.dart';
import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:cnn_brasil_app/features/article/article.dart';
import 'package:flutter/material.dart';
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
    final articleId =
        url.replaceAll('/?', '?').split('?').first.split('/').last;

    if (articleId.characters.length > 15) {
      NavigatorManager(context).to(
        Article.route,
        data: articleId,
        onFinished: () {},
      );
    } else {
      if (!url.contains('${ApiHome.home}/?s=') && url.contains(ApiHome.home)) {
        NavigatorManager(context).to(
          CustomWebView.route,
          data: WebviewNavigatorModel(url: url, title: 'Voltar'),
          onFinished: () {},
          analytics: NavigatorAnalytics.fromUrl(url),
        );
      }
    }    
  }

  void onSearch(String value) {
    _debounce(
      () async {
        controller.loadUrl(
          urlRequest: URLRequest(
            url: await WebUri(
                    '${ApiHome.home}/?s=$value&orderby=date&order=desc&hidemenu=true')
                .withThemeQuery(context),
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

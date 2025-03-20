// ignore_for_file: use_build_context_synchronously

import 'package:cnn_brasil_app/core/extensions/weburi_extension.dart';
import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:cnn_brasil_app/features/article/article.dart';
import 'package:cnn_brasil_app/features/article/article_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../core/index.dart';
import '../../core/repositories/live_repository.dart';
import '../index.dart';

abstract class HomeViewModel extends State<Home> with WidgetsBindingObserver {
  List<CnnMenuModel> listOfHomeMenu = [];
  final scrollControllerMenu = ScrollController();

  CnnMenuModel? selectedMenu;

  final liveRepository = LiveRepository(ApiConnector());

  String liveUrl = '';

  String currentUrl = '';

  LiveOnModel? liveOnModel;

  InAppWebViewController? inAppWebViewController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        loadView();
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.resumed == state) {
      loadView();
    }
  }

  Future<void> loadView() async {
    try {
      listOfHomeMenu = await HomeRepository(ApiConnector()).menuHome();
    } finally {
      setState(() {});
    }
    loadOnlive();
  }

  loadOnlive() async {
    try {
      liveOnModel = await liveRepository.onLive();
      liveUrl =
          '${ApiHome.home}/youtube/video/?youtube_id=${liveOnModel?.live?.video?.id}&youtube_adformat=aovivo&hidemenu=true&youtube_mode=teatro';

      Logger.log(liveUrl);
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  void navigateToInternalPage(String url) {
    if (url.contains("esportes") && (url.endsWith("#ao-vivo?hidemenu=true") || url.endsWith("#ao-vivo"))) {
      var newUrl = '${url.split("#ao-vivo")[0]}?hidemenu=true#ao-vivo';

      NavigatorManager(context).to(
        CustomWebView.route,
        data: WebviewNavigatorModel(url: newUrl, title: 'Voltar'),
        onFinished: () {
          inAppWebViewController?.goBack();
        },
        analytics: NavigatorAnalytics.fromUrl(newUrl),
      );

      return;
    }

    final articleId =
        url.replaceAll('/?', '?').split('?').first.split('/').last;

    if (articleId.characters.length > 15) {
      NavigatorManager(context).to(
        Article.route,
        data: ArticleSettings(articleId: articleId, articleUrl: url),
        onFinished: () => inAppWebViewController?.goBack(),
      );
    } else {
      NavigatorManager(context).to(
        CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Voltar'),
        onFinished: () {
          inAppWebViewController?.goBack();
        },
        analytics: NavigatorAnalytics.fromUrl(url),
      );
    }
  }

  void onMenuSelected(CnnMenuModel menu) async {
    setState(() {
      selectedMenu = menu;
    });
    try {
      inAppWebViewController?.loadUrl(
        urlRequest: URLRequest(
          url:
              await WebUri('${menu.url}?hidemenu=true').withThemeQuery(context),
        ),
      );
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {}
  }

  void onTapLogo() async {
    scrollControllerMenu.animateTo(0,
        duration: Durations.short2, curve: Curves.linear);

    setState(() {
      if (listOfHomeMenu.isNotEmpty) {
        selectedMenu = null;
      }
    });

    try {
      inAppWebViewController?.loadUrl(
        urlRequest: URLRequest(
          url: await WebUri('${ApiHome.home}/?hidemenu=true')
              .withThemeQuery(context),
        ),
      );
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {}
  }

  Future<void> login() async {
    NavigatorManager(context).modal(const Profile(), fullscreenDialog: true);
  }

  void openMenu() async {
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
          inAppWebViewController?.reload();
        },
        avatar: AppManager.user != null
            ? Image.network(AppManager.user?.picture ?? '')
            : null,
      ),
    );
  }
}

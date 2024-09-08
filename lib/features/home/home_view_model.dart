// ignore_for_file: use_build_context_synchronously

import 'package:cnn_brasil_app/core/extensions/uri_extension.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import '../../core/repositories/live_repository.dart';
import '../index.dart';

abstract class HomeViewModel extends State<Home> with WidgetsBindingObserver {
  List<CnnMenuModel> listOfHomeMenu = [];
  final scrollControllerMenu = ScrollController();
  bool isLoading = true;
  bool isFromMenu = true;
  CnnMenuModel? selectedMenu;
  final webViewController = WebViewController();

  final liveRepository = LiveRepository(ApiConnector());

  String liveUrl = '';

  String currentUrl = '';

  LiveOnModel? liveOnModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(const Color(0x00000000));
    webViewController.enableZoom(false);
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
          if (!isFromMenu && url.split('?').first != '${ApiHome.home}/') {
            navigateToInternalPage(url);
            return;
          }
          isFromMenu = false;
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (error) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );

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
    isFromMenu = true;
    try {
      webViewController.loadRequest(
          await Uri.parse('${ApiHome.home}/?hidemenu=true')
              .withThemeQuery(context));
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
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Voltar'), onFinished: () {
      loadView();
    });
  }

  void onMenuSelected(CnnMenuModel menu) {
    isFromMenu = true;
    setState(() {
      selectedMenu = menu;
    });
    try {
      Uri.parse('${menu.url}?hidemenu=true')
          .withThemeQuery(context)
          .then((uri) {
        webViewController.loadRequest(uri);
      });
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {}
  }

  void onTapLogo() {
    isFromMenu = true;
    scrollControllerMenu.animateTo(0,
        duration: Durations.short2, curve: Curves.linear);

    setState(() {
      if (listOfHomeMenu.isNotEmpty) {
        selectedMenu = null;
      }
    });

    try {
      Uri.parse('${ApiHome.home}/?hidemenu=true')
          .withThemeQuery(context)
          .then((uri) {
        webViewController.loadRequest(uri);
      });
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
        },
        avatar: AppManager.user != null
            ? Image.network(AppManager.user?.picture ?? '')
            : null,
      ),
    );
  }
}

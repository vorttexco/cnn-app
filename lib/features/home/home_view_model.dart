// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

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
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Voltar'), onFinished: () {
      inAppWebViewController?.goBack();
    });
  }

  void onMenuSelected(CnnMenuModel menu) {
    setState(() {
      selectedMenu = menu;
    });
    try {
      inAppWebViewController?.loadUrl(
          urlRequest: URLRequest(url: WebUri('${menu.url}?hidemenu=true')));
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {}
  }

  void onTapLogo() {
    scrollControllerMenu.animateTo(0,
        duration: Durations.short2, curve: Curves.linear);

    setState(() {
      if (listOfHomeMenu.isNotEmpty) {
        selectedMenu = null;
      }
    });

    try {
      inAppWebViewController?.loadUrl(
          urlRequest:
              URLRequest(url: WebUri('${ApiHome.home}/?hidemenu=true')));
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {}
  }

  Future<void> login() async {
    NavigatorManager(context).modal(const Profile(), fullscreenDialog: true);
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
}

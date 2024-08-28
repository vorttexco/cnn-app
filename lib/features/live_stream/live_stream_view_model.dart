import 'package:cnn_brasil_app/core/firebase_analytics_manager.dart';
import 'package:cnn_brasil_app/core/models/wrapper_live_strem_model.dart';
import 'package:cnn_brasil_app/core/repositories/live_repository.dart';
import 'package:cnn_brasil_app/features/live_stream/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class LiveStreamViewModel extends State<LiveStream> {
  final liveRepository = LiveRepository(ApiConnector());
  final pageController = PageController();

  LiveOnModel? liveOnModel;
  bool playOrPause = false;
  int indexMenuSelected = 0;
  MenuModel? menuSelected;

  final liveOnController = WebViewController();

  final listOfMenu = MenuModel.listOfMenu();
  var menu0 = WrapperLiveStreamModel(title: '', items: []);
  var menu1 = WrapperLiveStreamModel(title: '', items: []);
  var menu2 = WrapperLiveStreamModel(title: '', items: []);
  var menu3 = WrapperLiveStreamModel(title: '', items: []);
  var menu4 = WrapperLiveStreamModel(title: '', items: []);
  var menu5 = WrapperLiveStreamModel(title: '', items: []);
  var menu6 = WrapperLiveStreamModel(title: '', items: []);
  var menu7 = WrapperLiveStreamModel(title: '', items: []);
  var menu8 = WrapperLiveStreamModel(title: '', items: []);
  var menu9 = WrapperLiveStreamModel(title: '', items: []);
  var menu10 = WrapperLiveStreamModel(title: '', items: []);
  var menu11 = WrapperLiveStreamModel(title: '', items: []);
  var menu12 = WrapperLiveStreamModel(title: '', items: []);

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));

    liveOnController.setJavaScriptMode(JavaScriptMode.unrestricted);
    liveOnController.enableZoom(false);

    liveOnController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {},
        onPageFinished: (x) async {},
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        loadView();
      },
    );
  }

  Future<void> loadView() async {
    FirebaseAnalyticsManager.logScreen(screenName: 'ao-vivo');
    loadOnlive();
    loadMenu0();
    loadMenu1();
    loadMenu2();
    loadMenu3();
    loadMenu4();
    loadMenu5();
    loadMenu6();
    loadMenu7();
    loadMenu8();
    loadMenu9();
    loadMenu10();
    loadMenu11();
    loadMenu12();
  }

  loadOnlive() async {
    try {
      liveOnModel = await liveRepository.onLive();
      final url =
          '${ApiHome.home}/youtube/video/?youtube_id=${liveOnModel?.live?.video?.id}&youtube_adformat=${listOfMenu[indexMenuSelected].adformat}?hidemenu=true';
      Logger.log(url);

      liveOnController.loadRequest(Uri.parse(url));
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu0() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[1].playlist);
      menu0 = WrapperLiveStreamModel(
          title: listOfMenu[1].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu1() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[2].playlist);
      menu1 = WrapperLiveStreamModel(
          title: listOfMenu[2].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu2() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[3].playlist);
      menu2 = WrapperLiveStreamModel(
          title: listOfMenu[3].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu3() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[4].playlist);
      menu3 = WrapperLiveStreamModel(
          title: listOfMenu[4].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu4() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[5].playlist);
      menu4 = WrapperLiveStreamModel(
          title: listOfMenu[5].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu5() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[6].playlist);
      menu5 = WrapperLiveStreamModel(
          title: listOfMenu[6].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu6() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[7].playlist);
      menu6 = WrapperLiveStreamModel(
          title: listOfMenu[7].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu7() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[8].playlist);
      menu7 = WrapperLiveStreamModel(
          title: listOfMenu[8].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu8() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[9].playlist);
      menu8 = WrapperLiveStreamModel(
          title: listOfMenu[9].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu9() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[10].playlist);
      menu9 = WrapperLiveStreamModel(
          title: listOfMenu[10].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu10() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[11].playlist);
      menu10 = WrapperLiveStreamModel(
          title: listOfMenu[11].title,
          items: list
              .take(AppConstants.TOTAL_PLAYLIST_FULL)
              .toList()
              .take(15)
              .toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu11() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[12].playlist);
      menu11 = WrapperLiveStreamModel(
          title: listOfMenu[12].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  loadMenu12() async {
    try {
      final list = await liveRepository.playlist(listOfMenu[13].playlist);
      menu12 = WrapperLiveStreamModel(
          title: listOfMenu[13].title,
          items: list.take(AppConstants.TOTAL_PLAYLIST_FULL).toList());
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
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

  onSelectedMenu(MenuModel model, int index) {
    FirebaseAnalyticsManager.logScreenWithTag(
        screenName: 'ao-vivo', tagName: model.title);
    pageController.jumpToPage(index);
    setState(() {
      menuSelected = model;
      indexMenuSelected = index;
    });
  }

  onPageChanged(int index) {
    setState(() {
      indexMenuSelected = index;
    });
  }

  onSelectVideo(LiveStreamModel model) {
    setState(() {
      playOrPause = false;
    });
    final controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.enableZoom(false);
    Logger.log(controller.getUserAgent().toString());

    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {},
        onPageFinished: (x) async {},
      ),
    );
    final url =
        '${ApiHome.home}/youtube/video/?youtube_id=${model.id}&youtube_adformat=${listOfMenu[indexMenuSelected].adformat}?hidemenu=true';
    Logger.log(url);

    controller.loadRequest(Uri.parse(url));

    NavigatorManager(context).modalVideo(
      Center(
        child: SizedBox(
          height: 220,
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );

    // YoutubePlayerController controller = YoutubePlayerController(
    //   initialVideoId: model.id ?? '',
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: true,
    //   ),
    // );
    // NavigatorManager(context).modalVideo(
    //   YoutubePlayerBuilder(
    //     player: YoutubePlayer(
    //       controller: controller,
    //     ),
    //     builder: (context, player) {
    //       return Center(child: player);
    //     },
    //   ),
    // );
  }
}

import 'package:cnn_brasil_app/core/models/wrapper_stories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class StoriesViewModel extends State<Stories> {
  List<StorieViewModel> listOfStories = [];
  final scrollControler = ScrollController();

  StorieViewModel? storieViewSelected;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
    loadView();
  }

  Future<void> loadView() async {
    try {
      context.loaderOverlay.show();
      final response = await StorieRepository(ApiConnector()).listAll();
      listOfStories = WrapperStories.toView(response);
      storieViewSelected = listOfStories.firstOrNull;
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      context.loaderOverlay.hide();
      setState(() {});
    }
  }

  onSelectedMenu(StorieViewModel storie) {
    setState(() {
      storieViewSelected = storie;
      scrollControler.jumpTo(0);
    });
  }

  openLink(StorieModel? storie) {
    if (storie == null) return;
    NavigatorManager(context).modal(
      StorieDetail(url: '${storie.permalink}?hidemenu=true'),
      fullscreenDialog: true,
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
}

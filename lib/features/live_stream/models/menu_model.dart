import 'package:cnn_brasil_app/features/live_stream/mock/playlist.dart';

class MenuModel {
  final String title;
  final String playlist;
  final String adformat;

  MenuModel(
      {required this.adformat, required this.title, required this.playlist});

  static List<MenuModel> listOfMenu() {
    List<MenuModel> list = [];
    for (var menu in listMenu as List) {
      list.add(MenuModel(
          title: menu['title'],
          playlist: menu['playlist'],
          adformat: menu['adformat']));
    }
    return list;
  }
}

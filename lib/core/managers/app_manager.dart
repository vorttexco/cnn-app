import 'package:cnn_brasil_app/core/index.dart';

class AppManager {
  static UserModel? _userModel;

  static UserModel? get user => _userModel;

  static setUser(UserModel? model) {
    _userModel = model;
  }

  static bool _isFullScreen = false;

  static bool get isFullScreen => _isFullScreen;

  static void setFullScreen(bool value) {
    _isFullScreen = value;
  }

  static Future<bool> isLogged() async {
    return true;
  }

  static String _hostApi = '';

  static String get hostApi => _hostApi;

  static setBaseUrl(String url) {
    _hostApi = url;
  }
}

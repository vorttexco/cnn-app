import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  Future<bool> setString(String key, String value) async {
    final storage = await SharedPreferences.getInstance();
    return await storage.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final storage = await SharedPreferences.getInstance();
    final data = storage.getString(key);
    return data;
  }

  Future<bool> setBool(
    String key,
    bool value,
  ) async {
    final storage = await SharedPreferences.getInstance();
    return await storage.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final storage = await SharedPreferences.getInstance();
    return storage.getBool(key);
  }

  Future<bool> deleteKey(String key) async {
    final storage = await SharedPreferences.getInstance();
    return await storage.remove(key);
  }

  Future<bool> reset() async {
    final storage = await SharedPreferences.getInstance();
    return await storage.clear();
  }
}

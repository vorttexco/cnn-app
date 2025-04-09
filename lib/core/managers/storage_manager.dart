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

  Future<void> saveAnalyticsData({
    required String articleTitle,
    required String articleUrl,
    required String articleId,
    required String? firebasePreviousScreen,
    required String? firebasePreviousClass,
    required String? firebasePreviousId,
    required String pageAuthor,
    required String pagePublicationDate,
    required String pageCategory,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    await prefs.setString('${articleId}_firebase_screen', articleTitle);
    await prefs.setString('${articleId}_firebase_screen_class', articleUrl);
    await prefs.setString('${articleId}_firebase_screen_id', articleId);
    await prefs.setString('${articleId}_firebase_previous_screen', firebasePreviousScreen ?? '');
    await prefs.setString('${articleId}_firebase_previous_class', firebasePreviousClass ?? '');
    await prefs.setString('${articleId}_firebase_previous_id', firebasePreviousId ?? '');
    await prefs.setString('${articleId}_engagement_time_msec', DateTime.now().millisecondsSinceEpoch.toString());
    await prefs.setString('${articleId}_page_author_1', pageAuthor);
    await prefs.setString('${articleId}_page_publication_date', pagePublicationDate);
    await prefs.setString('${articleId}_page_category', pageCategory);
  }

  Future<Map<String, String>> getAnalyticsData({ required String articleId }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return {
      'firebase_screen': prefs.getString('${articleId}_firebase_screen') ?? '',
      'firebase_screen_class': prefs.getString('${articleId}_firebase_screen_class') ?? '',
      'firebase_screen_id': prefs.getString('${articleId}_firebase_screen_id') ?? '',
      'firebase_previous_screen': prefs.getString('${articleId}_firebase_previous_screen') ?? '',
      'firebase_previous_class': prefs.getString('${articleId}_firebase_previous_class') ?? '',
      'firebase_previous_id': prefs.getString('${articleId}_firebase_previous_id') ?? '',
      'engagement_time_msec': prefs.getString('${articleId}_engagement_time_msec') ?? '0',
      'page_author_1': prefs.getString('${articleId}_page_author_1') ?? '',
      'page_publication_date': prefs.getString('${articleId}_page_publication_date') ?? '',
      'page_category': prefs.getString('${articleId}_page_category') ?? '',
    };
  }
}

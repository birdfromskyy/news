import 'package:shared_preferences/shared_preferences.dart';

class OfflineStorage {
  static Future<void> saveArticle(String articleId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> articles = prefs.getStringList('recentArticles') ?? [];
    if (!articles.contains(articleId)) {
      articles.add(articleId);
      prefs.setStringList('recentArticles', articles);
    }
  }

  static Future<List<String>> getRecentArticles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recentArticles') ?? [];
  }
}

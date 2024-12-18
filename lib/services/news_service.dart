import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = "f5122c55c3f945949861412229e47745";
  final String baseUrl = "https://newsapi.org/v2/";

  Future<List<dynamic>> fetchNews(
      {String query = "",
      String? fromDate,
      String? toDate,
      String? tag}) async {
    final formattedFromDate = fromDate != null ? fromDate.split('T').first : '';
    final formattedToDate = toDate != null ? toDate.split('T').first : '';
    final url = Uri.parse(
        "${baseUrl}everything?q=${query}&from=${formattedFromDate}&to=${formattedToDate}&sortBy=publishedAt&language=en&apiKey=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['articles'];
    } else {
      throw Exception("Failed to fetch news");
    }
  }
}

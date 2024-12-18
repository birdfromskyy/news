import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../services/offline_storage.dart';
import 'news_detail_page.dart';
import 'package:intl/intl.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final NewsService newsService = NewsService();
  List<dynamic> articles = [];
  bool isLoading = true;
  String? selectedTag;
  DateTime? selectedDate;
  final TextEditingController tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedArticles = await newsService.fetchNews(
        query: selectedTag ?? "technology",
        fromDate: selectedDate?.toIso8601String(),
        toDate: selectedDate?.toIso8601String(),
      );
      setState(() {
        articles = fetchedArticles;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
      fetchNews();
    }
  }

  String formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd.MM.yyyy, HH:mm').format(dateTime);
    } catch (e) {
      return "Дата недоступна";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новостной клиент"),
        actions: [
          IconButton(
              onPressed: selectDate, icon: const Icon(Icons.calendar_today)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tagController,
              decoration: InputDecoration(
                labelText: 'Введите тег',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      selectedTag = tagController.text;
                    });
                    fetchNews();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: articles.length > 20 ? 20 : articles.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return ListTile(
                        title: Text(article['title'] ?? ""),
                        subtitle:
                            Text(formatDate(article['publishedAt'] ?? "")),
                        onTap: () async {
                          await OfflineStorage.saveArticle(
                              article['title'] ?? "");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailPage(article: article),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final dynamic article;

  const NewsDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['title'] ?? "")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article['title'] ?? "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(article['content'] ?? "Контент недоступен"),
          ],
        ),
      ),
    );
  }
}

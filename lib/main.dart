import 'package:flutter/material.dart';
import 'pages/news_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Новостной клиент',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NewsListPage(),
    );
  }
}

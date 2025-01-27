import 'package:flutter/material.dart';
import 'article_view.dart';

class Article extends StatefulWidget {
  static const route = '/Article/';
  final String articleId;
  const Article({super.key, required this.articleId});

  @override
  ArticleView createState() => ArticleView();
}

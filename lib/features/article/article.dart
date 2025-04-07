import 'package:cnn_brasil_app/features/article/article_settings.dart';
import 'package:flutter/material.dart';
import 'article_view.dart';

class Article extends StatefulWidget {
  static const route = '/Article/';
  final ArticleSettings model;
  
  const Article({super.key, required this.model});

  @override
  ArticleView createState() => ArticleView();
}

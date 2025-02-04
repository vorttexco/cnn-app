// ignore_for_file: use_build_context_synchronously
import 'package:cnn_brasil_app/core/models/article_gallery_model.dart';
import 'package:cnn_brasil_app/core/models/article_model.dart';
import 'package:cnn_brasil_app/core/models/article_most_read_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import 'article.dart';

abstract class ArticleViewModel extends State<Article> {
  late final ArticleModel article;
  late final ArticleMostReadModel articlesMostRead;
  late final ArticleGalleryModel articleGallery;

  bool fetched = false;

  @override
  void initState() {
    super.initState();

    fetch();
  }

  void fetch() async {
    final dio = Dio();

    final articleId = widget.articleId;

    final articleResponse = await dio.get(
      'https://www.cnnbrasil.com.br/wp-json/content/v1/posts/$articleId',
    );

    article = ArticleModel.fromJson(articleResponse.data);

    final responses = await Future.wait([
      dio.get(
        'https://www.cnnbrasil.com.br/wp-json/content/v1/posts/most-read',
        queryParameters: {
          'category': article.category?.hierarchy?.first,
          'per_page': 5,
        },
      ).catchError((e) {
        return Response(requestOptions: RequestOptions(path: ''));
      }),
      dio.get(
        'https://www.cnnbrasil.com.br/wp-json/content/v1/gallery/${article.featuredMedia?.gallery?.id}'
      ).catchError((e) {
        return Response(requestOptions: RequestOptions(path: ''));
      }),
    ]);

    final mostReadResponse = responses[0];
    final articleGalleryResponse = responses[1];

    articlesMostRead = ArticleMostReadModel.fromJson(mostReadResponse.data);
    
    if (articleGalleryResponse.data is Map<String, dynamic> && 
        !articleGalleryResponse.data.containsKey('mensagem')) {
      articleGallery = ArticleGalleryModel.fromJson(articleGalleryResponse.data);
    } else {
      articleGallery = ArticleGalleryModel();
    }

    if (article.content == null) {
      NavigatorManager(context).back();

      return;
    }

    setState(() {
      fetched = true;
    });
  }

  Future<List<StorieModel>> getWebStorie() async {
    final response = await StorieRepository(ApiConnector())
        .listCategory(article.category!.id ?? '');

    return response.length >= 3
        ? response.sublist(0, 3)
        : response.length >= 2
            ? response.sublist(0, 2)
            : [response.first];
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    String formattedDate =
        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return "$formattedDate às $formattedTime";
  }

  onBack() async {
    NavigatorManager(context).back();
  }

  onShare() {
    // final url = currentUrl.replaceAll('?hidemenu=true', '');
    // Share.share(url, subject: 'CNN Brasil');
  }
}

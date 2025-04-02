// ignore_for_file: use_build_context_synchronously
import 'package:cnn_brasil_app/core/models/article_gallery_model.dart';
import 'package:cnn_brasil_app/core/models/article_model.dart';
import 'package:cnn_brasil_app/core/models/article_most_read_model.dart';
import 'package:cnn_brasil_app/core/models/article_partners_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import 'article.dart';

abstract class ArticleViewModel extends State<Article> {
  late final ArticleModel article;
  late final String articleType;
  late final String articleUrl;
  late final ArticleMostReadModel articlesMostRead;
  late final ArticleGalleryModel articleGallery;
  late final ArticlePartnersModel articlePartners;

  bool fetched = false;

  @override
  void initState() {
    super.initState();

    fetch();
  }

  @override
  void dispose() async {
    await logScreenFirebase();

    super.dispose();
  }

  void fetch() async {
    try {
      final dio = Dio();

      final articleId = widget.model.articleId;

      if (widget.model.articleUrl.contains("/blogs/")) {
        final articleResponse = await dio.get(
          'https://www.cnnbrasil.com.br/wp-json/content/v1/posts/$articleId?post_type=blogs',
        );

        if (articleResponse.data is Map<String, dynamic>) {
          article = ArticleModel.fromJson(articleResponse.data);
          articleType = "Blog";
        }
      } else if (widget.model.articleUrl.contains("/colunas/")) {
        final articleResponse = await dio.get(
          'https://www.cnnbrasil.com.br/wp-json/content/v1/posts/$articleId?post_type=colunas',
        );

        if (articleResponse.data is Map<String, dynamic>) {
          article = ArticleModel.fromJson(articleResponse.data);
          articleType = "Coluna";
        }
      } else if (widget.model.articleUrl.contains("/forum")) {
        final articleResponse = await dio.get(
          'https://www.cnnbrasil.com.br/wp-json/content/v1/posts/$articleId?post_type=cnn-brasil-forum',
        );

        if (articleResponse.data is Map<String, dynamic>) {
          article = ArticleModel.fromJson(articleResponse.data);
          articleType = "forum";
        }
      } else if(widget.model.articleUrl.contains("/viagemegastronomia")) {
        final articleResponse = await dio.get(
          'https://www.cnnbrasil.com.br/viagemegastronomia/wp-json/content/v1/posts/$articleId',
        );

        if (articleResponse.data is Map<String, dynamic>) {
          article = ArticleModel.fromJson(articleResponse.data);
          articleType = "default";
        }
      } else if(widget.model.articleUrl.contains("/esportes/apostas/")) {
        final articleResponse = await dio.get(
          'https://www.cnnbrasil.com.br/esportes/apostas/wp-json/content/v1/posts/$articleId',
        );

        if (articleResponse.data is Map<String, dynamic>) {
          article = ArticleModel.fromJson(articleResponse.data);
          articleType = "default";
        }
      } else {
        final articleResponse = await dio.get(
          'https://www.cnnbrasil.com.br/wp-json/content/v1/posts/$articleId',
        );

        if (articleResponse.data is Map<String, dynamic>) {
          article = ArticleModel.fromJson(articleResponse.data);
          articleType = "default";
        }
      }

      if (article.content == null) {
        NavigatorManager(context).back();

        return;
      }

      articleUrl = widget.model.articleUrl;

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
        dio
            .get(
                'https://www.cnnbrasil.com.br/wp-json/content/v1/gallery/${article.featuredMedia?.gallery?.id}')
            .catchError((e) {
          return Response(requestOptions: RequestOptions(path: ''));
        }),
        dio
            .get(
                'https://www.cnnbrasil.com.br/wp-json/partners/v1/feed/${article.category?.hierarchy?.first}')
            .catchError((e) {
          return Response(requestOptions: RequestOptions(path: ''));
        }),
      ]);

      final mostReadResponse = responses[0];
      final articleGalleryResponse = responses[1];
      final articlePartnersResponse = responses[2];

      if (mostReadResponse.data is Map<String, dynamic>) {
        try {
          articlesMostRead =
              ArticleMostReadModel.fromJson(mostReadResponse.data);
        } catch (e) {
          articlesMostRead = ArticleMostReadModel(posts: []);
        }
      } else {
        articlesMostRead = ArticleMostReadModel(posts: []);
      }

      if (articlePartnersResponse.data is Map<String, dynamic>) {
        try {
          articlePartners =
              ArticlePartnersModel.fromJson(articlePartnersResponse.data);
        } catch (e) {
          articlePartners = ArticlePartnersModel(posts: []);
        }
      } else {
        articlePartners = ArticlePartnersModel(posts: []);
      }

      if (articleGalleryResponse.data is Map<String, dynamic> &&
          !articleGalleryResponse.data.containsKey('mensagem')) {
        try {
          articleGallery =
              ArticleGalleryModel.fromJson(articleGalleryResponse.data);
        } catch (e) {
          articleGallery = ArticleGalleryModel();
        }
      } else {
        articleGallery = ArticleGalleryModel();
      }

      var firebasePreviousScreen = await StorageManager().getString("firebase_previous_screen");
      var firebasePreviousClass = await StorageManager().getString("firebase_previous_class");
      var firebasePreviousId = await StorageManager().getString("firebase_previous_id");

      await StorageManager().saveAnalyticsData(
        articleTitle: article.title ?? '',
        articleUrl: articleUrl,
        articleId: article.id ?? '',
        firebasePreviousScreen: firebasePreviousScreen,
        firebasePreviousClass: firebasePreviousClass,
        firebasePreviousId: firebasePreviousId,
        pageAuthor: article.author?.list?.first.name ?? '',
        pagePublicationDate: article.publishDate ?? '',
        pageCategory: article.category?.name ?? '',
      );

      setState(() {
        fetched = true;
      });
    } catch (e) {
      NavigatorManager(context).back();

      return;
    }
  }

  Future<List<StorieModel>> getWebStorie() async {
    final response = await StorieRepository(ApiConnector())
        .listCategory(article.category?.hierarchy?.first ?? '');

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

  logScreenFirebase() async {
     try {
      Map<String, String> analyticsData = await StorageManager().getAnalyticsData(articleId: article.id ?? '');

      int? savedTime = int.tryParse(analyticsData["engagement_time_msec"] ?? '');

      int? differenceMs;

      if (savedTime != null) {
        differenceMs = DateTime.now().millisecondsSinceEpoch - savedTime;

        differenceMs = (differenceMs ~/ 1000) * 1000;
      }

      FirebaseAnalytics.instance.logScreenView(
        screenClass: articleUrl,
        screenName: article.title,
        parameters: {
          'firebase_screen': analyticsData["firebase_screen"] ?? '',
          'firebase_screen_class': analyticsData["firebase_screen_class"] ?? '',
          'firebase_screen_id': analyticsData["firebase_screen_id"] ?? '',
          'firebase_previous_screen': analyticsData["firebase_previous_screen"] ?? '',
          'firebase_previous_class': analyticsData["firebase_previous_class"] ?? '',
          'firebase_previous_id': analyticsData["firebase_previous_id"] ?? '',
          'engagement_time_msec': differenceMs ?? '',
          'page_author_1': analyticsData["page_author_1"] ?? '',
          'page_publication_date': analyticsData["page_publication_date"] ?? '',
          'page_category': analyticsData["page_category"] ?? '',
        },
      );
    } on Exception {
      //Could not call firebase
    }
  }  
}

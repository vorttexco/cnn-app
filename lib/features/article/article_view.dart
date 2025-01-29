import 'package:cnn_brasil_app/core/components/app_bar_webview.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/core/models/article_model.dart';
import 'package:cnn_brasil_app/core/models/article_most_read_model.dart';
import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:cnn_brasil_app/features/article/article.dart';
import 'package:cnn_brasil_app/features/article/article_css.dart';
import 'package:cnn_brasil_app/features/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'article_view_model.dart';

class ArticleView extends ArticleViewModel {
  Widget renderContent(String htmlSnippet) {
    final shouldRenderWebView = htmlSnippet.contains('flourish-embed') &&
        htmlSnippet.contains('data-src');

    if (shouldRenderWebView) {
      final match = RegExp(r'data-src="([^"]+)"').firstMatch(htmlSnippet);
      if (match != null) {
        final visualisationId = match.group(1);
        final visualisationUrl =
            'https://public.flourish.studio/$visualisationId/';

        return SizedBox(
          height: 400,
          width: double.infinity,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(visualisationUrl)),
          ),
        );
      }
    }

    return const Center(child: Text("Conteúdo não requer WebView"));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarwebView(
                  onFinished: () {
                    setState(() {});
                  },
                  title: 'Voltar',
                  onIconPressed: onBack,
                  onShare: onShare,
                ),
                if (fetched && article.content?.content != null) ...[
                  Text(
                    article.title ?? '',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Divider(),
                  Text(
                    article.excerpt ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.KPADDING_8),
                  if ((article.author?.list ?? []).isNotEmpty)
                    RichText(
                      text: TextSpan(
                        text: article.author!.list!.first.name,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text:
                                ', ${article.author!.list!.first.type!.name!}',
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppConstants.KPADDING_8),
                  Text(
                    formatDateTime(article.publishDate!),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.KPADDING_8),
                  if (article.featuredMedia?.image != null) ...[
                    Image.network(article.featuredMedia!.image!.url!),
                    const SizedBox(height: AppConstants.KPADDING_8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: RichText(
                        text: TextSpan(
                          text: article.featuredMedia!.image!.caption,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ' • ${article.featuredMedia!.image!.credits}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.KPADDING_8),
                    const Divider(),
                    // if (article.permalink != null) ...[
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 10, vertical: 2),
                    //     child: InkWell(
                    //       onTap: () =>
                    //           Share.shareUri(Uri.parse(article.permalink!)),
                    //       child: SizedBox(
                    //         height: 40,
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               width: 40,
                    //               height: 40,
                    //               decoration: BoxDecoration(
                    //                 color: Theme.of(context).primaryColor,
                    //                 shape: BoxShape.circle,
                    //               ),
                    //               padding: const EdgeInsets.only(right: 3),
                    //               child: const Icon(
                    //                 Icons.share,
                    //                 color: Colors.white,
                    //                 size: 25,
                    //               ),
                    //             ),
                    //             const SizedBox(width: 10),
                    //             Text(
                    //               'Compartilhar matéria',
                    //               style: TextStyle(
                    //                 color: Theme.of(context).colorScheme.primary,
                    //                 fontSize: 14,
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   const Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 10),
                    //     child: Divider(),
                    //   ),
                    // ]
                  ],
                  HtmlWidget(
                    article.content!.content!.replaceAll('"', '"'),
                    textStyle: const TextStyle(
                      fontFamily: 'CNN Sans Display W04 Medium',
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      // height: 26,
                    ),
                    onTapUrl: (url) {
                      final articleId = url
                          .replaceAll('/?', '?')
                          .split('?')
                          .first
                          .split('/')
                          .last;

                      if (articleId.characters.length > 15) {
                        NavigatorManager(context)
                            .to(Article.route, data: articleId);
                      } else {
                        NavigatorManager(context).to(
                          CustomWebView.route,
                          data:
                              WebviewNavigatorModel(url: url, title: 'Voltar'),
                          onFinished: () {},
                          analytics: NavigatorAnalytics.fromUrl(url),
                        );
                      }

                      return false;
                    },
                    customStylesBuilder: (element) => cssBuilder(
                      element,
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).primaryColor,
                    ),
                    customWidgetBuilder: (element) {
                      if (element.localName == 'iframe' &&
                          (element.attributes.containsKey('src') ||
                              element.attributes.containsKey('data-src'))) {
                        return SizedBox(
                          height: 400,
                          child: InAppWebView(
                            initialUrlRequest: URLRequest(
                              url: WebUri(element.attributes['src'] ??
                                  element.attributes['data-src']!),
                            ),
                          ),
                        );
                      }
                      if (element.localName == 'div' &&
                          element.attributes.containsKey('data-src')) {
                        return renderContent(element.outerHtml);
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tópicos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (ArticleTags tag in article.tags ?? [])
                        InkWell(
                          onTap: tag.permalink != null
                              ? () {
                                  NavigatorManager(context).to(
                                    CustomWebView.route,
                                    data: WebviewNavigatorModel(
                                        url: tag.permalink!, title: 'Voltar'),
                                    onFinished: () {},
                                    analytics: NavigatorAnalytics.fromUrl(
                                      tag.permalink!,
                                    ),
                                  );
                                }
                              : null,
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                              maxHeight: 40,
                              minHeight: 40,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tag.name ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    'Mais Lidos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      InkWell(
                        onTap: () {
                          NavigatorManager(context).to(
                            CustomWebView.route,
                            data: WebviewNavigatorModel(
                                url: articlesMostRead.posts.first.permalink, title: 'Voltar'),
                            onFinished: () {},
                            analytics: NavigatorAnalytics.fromUrl(
                              articlesMostRead.posts.first.permalink,
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(articlesMostRead.posts.first.featuredMedia.image.url),
                            const SizedBox(height: 8),
                            Text(
                              articlesMostRead.posts.first.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),                        
                      for (Post post in articlesMostRead.posts.skip(1).take(4))
                        InkWell(
                          onTap: () {
                            NavigatorManager(context).to(
                              CustomWebView.route,
                              data: WebviewNavigatorModel(
                                  url: post.permalink, title: 'Voltar'),
                              onFinished: () {},
                              analytics: NavigatorAnalytics.fromUrl(
                                post.permalink,
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(post.featuredMedia.image.url),
                              const SizedBox(height: 8),
                              Text(
                                post.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  if (article.category != null) ...[
                    Text(
                      'WebStories ${article.category!.name ?? ''}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (article.category?.id != null)
                      FutureBuilder(
                        future: getWebStorie(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                for (var storie in snapshot.data!) ...[
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      NavigatorManager(context).modal(
                                        StorieDetail(
                                          url:
                                              '${storie.permalink}/?hidemenu=true',
                                        ),
                                        fullscreenDialog: true,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 80,
                                      child: Row(
                                        children: [
                                          if (storie.thumbnail != null)
                                            Image.network(
                                              storie.thumbnail!,
                                              width: 90,
                                              fit: BoxFit.cover,
                                            ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              storie.title ?? '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(
                                    thickness: .5,
                                  ),
                                ]
                              ],
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                  ]
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

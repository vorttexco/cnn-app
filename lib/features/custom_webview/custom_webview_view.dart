import 'package:cnn_brasil_app/core/components/app_bar_webview.dart';
import 'package:cnn_brasil_app/core/components/custom_inapp_web_view.dart';
import 'package:cnn_brasil_app/core/extensions/weburi_extension.dart';
import 'package:cnn_brasil_app/core/managers/navigator_manager.dart';
import 'package:cnn_brasil_app/features/article/article.dart';
import 'package:cnn_brasil_app/features/article/article_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import './custom_webview_view_model.dart';

class CustomWebviewView extends CustomWebviewViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            AppBarwebView(
              onFinished: () {
                setState(() {});
              },
              title: 'Voltar',
              onIconPressed: onBack,
              onShare: onShare,
            ),
            Expanded(
              child: FutureBuilder(
                future:
                    WebUri(widget.navigatorModel.url).withThemeQuery(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomInAppWebViewComponent(
                      initialUrl: snapshot.data!.rawValue,
                      onCreated: (InAppWebViewController controlerOrigin) {
                        controller = controlerOrigin;
                      },
                      openExternalUrl: (externalUrl) {
                        final articleId = externalUrl.replaceAll('/?', '?').split('?').first.split('/').last;

                        if (articleId.characters.length > 15) {
                          NavigatorManager(context).to(
                            Article.route,
                            data: ArticleSettings(articleId: articleId, articleUrl: externalUrl),
                            onFinished: () {
                              controller.goBack();
                            },
                          );
                        }
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

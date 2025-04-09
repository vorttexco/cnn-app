import 'package:cnn_brasil_app/core/extensions/weburi_extension.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/features/article/article.dart';
import 'package:cnn_brasil_app/features/article/article_settings.dart';
import 'package:cnn_brasil_app/features/custom_webview/custom_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomInAppWebViewComponent extends StatefulWidget {
  final GlobalKey? globalKey;
  final String initialUrl;
  final Function(String url)? openExternalUrl;
  final Function(String url)? openWithSystemBrowser;

  final Function(InAppWebViewController controller) onCreated;

  const CustomInAppWebViewComponent({
    super.key,
    this.globalKey,
    this.openExternalUrl,
    required this.initialUrl,
    required this.onCreated,
    this.openWithSystemBrowser,
  });

  @override
  State<CustomInAppWebViewComponent> createState() =>
      _CustomInAppWebViewComponentState();
}

class _CustomInAppWebViewComponentState
    extends State<CustomInAppWebViewComponent> with WidgetsBindingObserver {
  bool clicked = false;
  bool isLoading = false;
  double progress = 0;
  Brightness? _brightness;
  bool _visible = false;

  // Future? _urlFuture;

  InAppWebViewSettings settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: true,
    allowsInlineMediaPlayback: true,
    clearCache: true,
    javaScriptEnabled: true,
    disableDefaultErrorPage: false,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  InAppWebViewController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_brightness == null) return;

    final brightness = MediaQuery.of(context).platformBrightness;

    if (_brightness != brightness) {
      _brightness = brightness;

      _controller!.getUrl().then((uri) async {
        if (uri == null) return;

        clicked = false;
        _controller!.loadUrl(
          urlRequest: URLRequest(
            url: await uri.withThemeQuery(context),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _brightness ??= MediaQuery.of(context).platformBrightness;

    return _webView();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _webView() {
    return Stack(
      children: [
        Visibility(
          visible: _visible,
          maintainState: true,
          child: IgnorePointer(
            ignoring: _controller == null,
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
              onWebViewCreated: (controller) {
                controller.evaluateJavascript(source: '''
                  document.addEventListener('click', function(event) {
                    window.flutter_inappwebview.callHandler('elementClicked', 'clicked',);
                  });
                ''');

                controller.addJavaScriptHandler(
                    handlerName: 'elementClicked',
                    callback: (args) {
                      clicked = true;
                    });

                setState(() {
                  _controller = controller;
                  // _urlFuture = _controller!.getUrl();
                });

                widget.onCreated(controller);
              },
              initialSettings: settings,
              onLoadStop: (controller, url) async {
                await controller.evaluateJavascript(source: '''
                  document.addEventListener('click', function(event) {
                    window.flutter_inappwebview.callHandler('elementClicked', 'clicked',);
                  });
                ''');

                setState(() {
                  _visible = true;
                });
              },
              onLoadStart: (controller, url) async {
                // setState(() {
                //   _visible = url?.rawValue != "about:blank";
                //   // _urlFuture = _controller?.getUrl();
                // });

                if (url != null &&
                    url.authority != '' &&
                    !url.authority.contains('cnnbrasil.com.br')) {
                  if (clicked) {
                    clicked = false;
                  }
                  progress = 10;
                  InAppBrowser.openWithSystemBrowser(
                      url: WebUri(url.toString()));
                  Future.delayed(const Duration(seconds: 1)).then(
                    (value) {
                      controller.goBack();
                    },
                  );

                  widget.openWithSystemBrowser?.call(url.toString());

                  return;
                }

                if (url == null) return;

                final rawActual = url.rawValue.split('?').first;
                final rawOriginal = widget.initialUrl.split('?').first;

                if (clicked && rawActual != rawOriginal) {
                  widget.openExternalUrl?.call(url.toString());
                  clicked = false;
                  return;
                }
              },
              onReceivedHttpError: (controller, request, errorResponse) {},
              onLoadResource: (controller, url) {
                // controller.addJavaScriptHandler(
                //     handlerName: 'elementClicked',
                //     callback: (args) {
                //       clicked = true;
                //     });
              },
              onProgressChanged: (controller, progress) {
                Logger.log('progress $progress');
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
        progress < 1
            ? Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ),
              )
            : Container(),
        // if (_controller != null)
        //   FutureBuilder(
        //     future: _urlFuture,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return Text(
        //           snapshot.data!.rawValue,
        //           style: TextStyle(fontSize: 18, color: Colors.red),
        //         );
        //       } else {
        //         return const SizedBox();
        //       }
        //     },
        //   )
      ],
    );
  }
}

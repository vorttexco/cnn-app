import 'package:cnn_brasil_app/core/extensions/uri_extension.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class BlogsViewModel extends State<Blogs> {
  final webViewController = WebViewController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(const Color(0x00000000));
    webViewController.enableZoom(false);
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });

          if (url.split('?').first != ApiBlogs.blogs.split('?').first) {
            navigateToInternalPage(url);
            return;
          }
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (error) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _loadView();
      },
    );
  }

  Future<void> _loadView() async {
    try {
      webViewController
          .loadRequest(await Uri.parse(ApiBlogs.blogs).withThemeQuery(context));
    } catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> navigateToInternalPage(String url) async {
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Voltar'), onFinished: () {
      Uri.parse(ApiBlogs.blogs).withThemeQuery(context).then((uri) {
        webViewController.loadRequest(uri);
      });
    });
  }

  void openMenu() {
    NavigatorManager(context).fullModal(
      const NestedNavigator(child: HomeMenu()),
      header: AppBarInternal(
        textAlign: TextAlign.center,
        icon: SvgPicture.asset(
          'assets/icons/close_menu.svg',
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title: 'Seções',
        onIconPressed: () {
          Navigator.of(context).pop(true);
        },
        avatar: AppManager.user != null
            ? Image.network(AppManager.user?.picture ?? '')
            : null,
      ),
    );
  }
}

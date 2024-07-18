import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import './blogs_view_model.dart';

class BlogsView extends BlogsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarInternal(
            icon: SvgPicture.asset('assets/icons/menu.svg'),
            onIconPressed: openMenu,
            iconColor: Colors.black,
            titleWidget: const CustomText(
              'Blog',
              fontSize: AppConstants.KFONTSIZE_18,
              fontWeight: FontWeight.w700,
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            onFinished: () {
              setState(() {});
            },
            avatar: AppManager.user != null
                ? Image.network(AppManager.user?.picture ?? '')
                : null,
          ),
          Expanded(
            child: WebViewWidget(
              controller: webViewController,
            ),
          ),
        ],
      ),
    );
  }
}

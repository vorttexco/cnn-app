import 'package:cnn_brasil_app/core/components/custom_inapp_web_view.dart';
import 'package:cnn_brasil_app/core/extensions/weburi_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../core/index.dart';
import './blogs_view_model.dart';

class BlogsView extends BlogsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarInternal(
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            onIconPressed: openMenu,
            titleWidget: const CustomText(
              'Blogs',
              fontSize: AppConstants.KFONTSIZE_18,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            onFinished: () {
              setState(() {});
            },
            onThemeUpdated: () async {
              var url = await controller.getUrl();

              if (url == null) return;

              controller.loadUrl(
                  urlRequest:
                      URLRequest(url: await url.withThemeQuery(context)));
            },
            avatar: AppManager.user != null
                ? Image.network(AppManager.user?.picture ?? '')
                : null,
          ),
          Expanded(
            child: FutureBuilder(
              future: WebUri(ApiBlogs.blogs).withThemeQuery(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomInAppWebViewComponent(
                    onCreated: (controllerOrigin) {
                      controller = controllerOrigin;
                    },
                    initialUrl: snapshot.data!.rawValue,
                    openExternalUrl: navigateToInternalPage,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

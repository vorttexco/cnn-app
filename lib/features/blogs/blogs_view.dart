import 'package:cnn_brasil_app/core/extensions/uri_extension.dart';
import 'package:flutter/material.dart';

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
              var url = await webViewController.currentUrl();

              if (url == null) return;

              webViewController
                  .loadRequest(await Uri.parse(url).withThemeQuery(context));
            },
            avatar: AppManager.user != null
                ? Image.network(AppManager.user?.picture ?? '')
                : null,
          ),
          Expanded(
            child: CustomWebViewComponent(
              webViewController: webViewController,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}

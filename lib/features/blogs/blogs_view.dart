import 'package:cnn_brasil_app/core/components/custom_inapp_web_view.dart';
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
            icon: SvgPicture.asset('assets/icons/menu.svg'),
            onIconPressed: openMenu,
            iconColor: Colors.black,
            titleWidget: const CustomText(
              'Blogs',
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
            child: CustomInAppWebViewComponent(
              onCreated: (controllerOrigin) {
                controller = controllerOrigin;
              },
              initialUrl: ApiBlogs.blogs,
              openExternalUrl: navigateToInternalPage,
            ),
          ),
        ],
      ),
    );
  }
}

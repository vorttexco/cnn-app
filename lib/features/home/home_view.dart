import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_view_model.dart';

class HomeView extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabbarProvider>(
      builder:
          (BuildContext context, TabbarProvider tabBarView, Widget? child) {
        if (tabBarView.reloadHome) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Provider.of<TabbarProvider>(context, listen: false)
                  .setReloadHome(false);

              onTapLogo();
            },
          );
        }
        return _buildBody();
      },
    );
  }

  Scaffold _buildBody() {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      body: Column(
        children: [
          AppBarInternal(
            icon: SvgPicture.asset('assets/icons/menu.svg'),
            iconColor: Colors.black,
            onIconPressed: openMenu,
            titleWidget: SizedBox(
              height: 30,
              child: InkWell(
                  onTap: onTapLogo,
                  child: SvgPicture.asset('assets/icons/logo_cnn_header.svg')),
            ),
            avatar: AppManager.user != null
                ? Image.network(AppManager.user?.picture ?? '')
                : null,
            onFinished: () {
              setState(() {});
            },
          ),
          if (liveUrl != null && liveUrl.isNotEmpty)
              CustomPlayer(
                model: liveOnModel,
                url: liveUrl,
              ),
          MenuHorizontal(
            items: listOfHomeMenu,
            onSelectedMenu: onMenuSelected,
            selectedMenu: selectedMenu,
            scrollController: scrollControllerMenu,
          ),
          Expanded(
              child: CustomWebViewComponent(
            webViewController: webViewController,
            isLoading: isLoading,
          ))
        ],
      ),
    );
  }
}

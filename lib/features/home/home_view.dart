import 'package:cnn_brasil_app/core/extensions/uri_extension.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/core/providers/theme_provider.dart';
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
            titleWidget: SizedBox(
              height: 30,
              child: InkWell(
                onTap: onTapLogo,
                child: SvgPicture.asset(
                  'assets/icons/logo_cnn_header.svg',
                  colorFilter: Provider.of<ThemeProvider>(context).themeMode ==
                              ThemeMode.dark ||
                          (Provider.of<ThemeProvider>(context).themeMode ==
                                  ThemeMode.system &&
                              MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark)
                      ? const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
            ),
            avatar: AppManager.user != null
                ? Image.network(AppManager.user?.picture ?? '')
                : null,
            onFinished: () {
              setState(() {});
            },
            onThemeUpdated: () async {
              var url = await webViewController.currentUrl();

              if (url == null) return;

              webViewController
                  .loadRequest(await Uri.parse(url).withThemeQuery(context));
            },
          ),
          if (liveUrl.isNotEmpty)
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
            ),
          )
        ],
      ),
    );
  }
}

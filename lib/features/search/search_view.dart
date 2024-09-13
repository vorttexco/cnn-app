import 'package:cnn_brasil_app/core/extensions/weburi_extension.dart';
import 'package:cnn_brasil_app/core/providers/theme_provider.dart';
import 'package:cnn_brasil_app/core/components/custom_inapp_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../core/index.dart';
import './search_view_model.dart';

class SearchView extends SearchViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarInternal(
            onFinished: () {
              setState(() {});
            },
            onThemeUpdated: () async {
              var url = await controller.getUrl();

              if (url == null) return;

              controller.loadUrl(
                urlRequest: URLRequest(
                  url: await url.withThemeQuery(context),
                ),
              );
            },
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
                child: SvgPicture.asset('assets/icons/logo_cnn_header.svg',
                    colorFilter: Provider.of<ThemeProvider>(context)
                                    .themeMode ==
                                ThemeMode.dark ||
                            (Provider.of<ThemeProvider>(context).themeMode ==
                                    ThemeMode.system &&
                                MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark)
                        ? const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          )
                        : null),
              ),
            ),
            avatar: AppManager.user != null
                ? Image.network(AppManager.user?.picture ?? '')
                : null,
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          const SizedBox(height: AppConstants.KPADDING_DEFAULT),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.KPADDING_DEFAULT),
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.KPADDING_DEFAULT,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFD6D6D6),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/search_off.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  ),
                  const SizedBox(width: AppConstants.KPADDING_DEFAULT),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Pesquisar na CNN',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      onChanged: onSearch,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.KPADDING_DEFAULT),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          const SizedBox(height: AppConstants.KPADDING_DEFAULT),
          Expanded(
            child: CustomInAppWebViewComponent(
              initialUrl: '',
              onCreated: (controllerOrigin) {
                controller = controllerOrigin;
              },
              openExternalUrl: navigateToInternalPage,
            ),
          )
        ],
      ),
    );
  }
}

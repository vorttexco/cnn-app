import 'package:flutter/material.dart';

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
            icon: SvgPicture.asset('assets/icons/menu.svg'),
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
          ),
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
          const Divider(
            height: 1,
            color: Color(0xFFDCDCDC),
            thickness: 1,
          ),
          const SizedBox(height: AppConstants.KPADDING_DEFAULT),
          Expanded(
            child: CustomWebViewComponent(
              isLoading: isLoading,
              webViewController: webViewController,
            ),
          )
        ],
      ),
    );
  }
}

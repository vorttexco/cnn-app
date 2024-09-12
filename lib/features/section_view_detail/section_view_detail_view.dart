import 'package:cnn_brasil_app/core/components/custom_inapp_web_view.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import './section_view_detail_view_model.dart';

class SectionViewDetailView extends SectionViewDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            AppBarInternal(
              onFinished: () {
                setState(() {});
              },
              title: widget.model.title ?? '',
              onIconPressed: onBack,
              avatar: AppManager.user != null
                  ? Image.network(AppManager.user?.picture ?? '')
                  : null,
            ),
            Visibility(
              visible: listOfMenu.isNotEmpty,
              child: SizedBox(
                height: 32,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.KPADDING_DEFAULT,
                  ),
                  itemCount: listOfMenu.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final menu = listOfMenu[index];
                    return InkWell(
                      onTap: () => onSelectedMenu(menu),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: menuSelected?.id == menu.id
                                ? const Color(0xFF3F4952)
                                : Colors.transparent,
                            border: Border.all(
                                width: 1, color: const Color(0xFF8C8C8C))),
                        child: Center(
                          child: CustomText(
                            menu.title ?? '',
                            textColor: menuSelected?.id == menu.id
                                ? Colors.white
                                : const Color(0xFF8C8C8C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.KPADDING_DEFAULT),
            const Divider(
              color: Color(0xFFDCDCDC),
              thickness: 1,
            ),
            Expanded(
              child: CustomInAppWebViewComponent(
                initialUrl: '${widget.model.url}?hidemenu=true',
                onCreated: (controllerOrigin) {
                  controller = controllerOrigin;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

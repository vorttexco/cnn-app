import 'package:cnn_brasil_app/core/components/custom_inapp_web_view.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import './storie_detail_view_model.dart';

class StorieDetailView extends StorieDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: CustomInAppWebViewComponent(
              initialUrl: widget.url,
              onCreated: (controllerOrigin) {
                controller = controllerOrigin;
              },
            ),
          ),
          Positioned(
            top: 110,
            left: AppConstants.KFONTSIZE_16,
            child: InkWell(
              onTap: onBack,
              child: SvgPicture.asset(
                'assets/icons/close_menu.svg',
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          )
        ],
      ),
    );
  }
}

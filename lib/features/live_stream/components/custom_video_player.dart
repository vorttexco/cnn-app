// ignore_for_file: deprecated_member_use

import 'package:cnn_brasil_app/core/extensions/string_extension.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomVideoPlayer extends StatelessWidget {
  final LiveOnModel? model;
  final String? url;

  CustomVideoPlayer({
    super.key,
    required this.model,
    required this.url,
  });

  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: _createViewExpanded(context),
    );
  }

  Widget _createViewExpanded(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.KPADDING_DEFAULT,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.hardEdge,
            child: InAppWebView(
                  key: const Key('webView'),
                  initialUrlRequest: URLRequest(url: WebUri(url ?? "")),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                      mediaPlaybackRequiresUserGesture: false,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    ),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStop: (controller, url) async {
                    await controller.evaluateJavascript(
                      source: """
                      var video = document.querySelector('video');
                      if (video) {
                        video.style.width = '100%';
                        video.style.height = '100%';
                        video.play();
                      }
                      """
                    );
                  },
                ),
          ),
        ),
        const SizedBox(height: AppConstants.KPADDING_DEFAULT),
        Container(
          color: Theme.of(context).colorScheme.secondaryContainer,
          height: 80,
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.KPADDING_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        model?.live?.title ?? '',
                        fontWeight: FontWeight.w500,
                        fontSize: AppConstants.KFONTSIZE_12,
                        // fontHeight: 1.4,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'seg - sex',
                                fontWeight: FontWeight.w400,
                                textColor:
                                    Theme.of(context).colorScheme.secondary,
                                fontSize: AppConstants.KFONTSIZE_12,
                                fontHeight: 1.4,
                              ),
                              CustomText(
                                model?.live?.startTime?.hour ?? '',
                                fontWeight: FontWeight.w400,
                                textColor:
                                    Theme.of(context).colorScheme.secondary,
                                fontSize: AppConstants.KFONTSIZE_12,
                                fontHeight: 1.4,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'Apresentação',
                                  fontWeight: FontWeight.w400,
                                  textColor:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: AppConstants.KFONTSIZE_12,
                                  fontHeight: 1.4,
                                ),
                                CustomText(
                                  model?.live?.presenter ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppConstants.KFONTSIZE_12,
                                  // fontHeight: 1.4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Flexible(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          'A seguir',
                          fontWeight: FontWeight.w500,
                          textColor: Theme.of(context).colorScheme.secondary,
                          fontSize: AppConstants.KFONTSIZE_12,
                          // fontHeight: 1.4,
                        ),
                        const Spacer(),
                        CustomText(
                          model?.next?.first.startTime?.hour ?? '',
                          fontWeight: FontWeight.w500,
                          fontSize: AppConstants.KFONTSIZE_12,
                          // fontHeight: 1.4,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Image.network(
                        model?.next?.first.logo ??
                            '${ApiHome.home}/wp-content/uploads/sites/12/2023/09/logo_CNN_Prime_Time_2023_white.png',
                        // model?.next?.first.logo ??
                        //     '${ApiHome.home}/wp-content/uploads/sites/12/2023/09/logo_CNN_Prime_Time_2023_white.png',
                        width: 60,
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
        const SizedBox(height: AppConstants.KPADDING_DEFAULT),
      ],
    );
  }
}

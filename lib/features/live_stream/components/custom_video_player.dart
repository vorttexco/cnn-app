import 'package:cnn_brasil_app/core/extensions/string_extension.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomVideoPlayer extends StatelessWidget {
  final LiveOnModel? model;
  final WebViewController? webViewController;

  const CustomVideoPlayer({
    super.key,
    required this.model,
    this.webViewController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF282828),
      ),
      child: _createViewExpanded(),
    );
  }

  Widget _createViewExpanded() {
    return Column(
      children: [
        Container(
          height: 220,
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.KPADDING_DEFAULT),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.hardEdge,
            child: WebViewWidget(
              controller: webViewController ?? WebViewController(),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.KPADDING_DEFAULT),
        Container(
          color: const Color(0xFF282828),
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
                        textColor: Colors.white,
                        fontSize: AppConstants.KFONTSIZE_12,
                        // fontHeight: 1.4,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                'seg - sex',
                                fontWeight: FontWeight.w400,
                                textColor: Color(0xFFB9B9B9),
                                fontSize: AppConstants.KFONTSIZE_12,
                                fontHeight: 1.4,
                              ),
                              CustomText(
                                model?.live?.startTime?.hour ?? '',
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xFFB9B9B9),
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
                                const CustomText(
                                  'Apresentação',
                                  fontWeight: FontWeight.w400,
                                  textColor: Color(0xFFB9B9B9),
                                  fontSize: AppConstants.KFONTSIZE_12,
                                  fontHeight: 1.4,
                                ),
                                CustomText(
                                  model?.live?.presenter ?? '',
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.white,
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
                color: const Color(0xFF565656),
              ),
              Flexible(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CustomText(
                          'A seguir',
                          fontWeight: FontWeight.w500,
                          textColor: Color(0xFF909090),
                          fontSize: AppConstants.KFONTSIZE_12,
                          // fontHeight: 1.4,
                        ),
                        const Spacer(),
                        CustomText(
                          model?.next?.first.startTime?.hour ?? '',
                          fontWeight: FontWeight.w500,
                          textColor: Colors.white,
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

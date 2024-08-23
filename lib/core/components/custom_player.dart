import 'package:cnn_brasil_app/core/extensions/string_extension.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomPlayer extends StatefulWidget {
  final LiveOnModel? model;
  final String url;

  const CustomPlayer({
    super.key,
    required this.model,
    required this.url,
  });

  @override
  State<CustomPlayer> createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<CustomPlayer> {
  final collapsedControle = WebViewController();
  final expandedController = WebViewController();

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    collapsedControle.setJavaScriptMode(JavaScriptMode.unrestricted);
    collapsedControle.enableZoom(false);

    collapsedControle.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {},
        onPageFinished: (x) async {},
      ),
    );

    expandedController.setJavaScriptMode(JavaScriptMode.unrestricted);
    expandedController.enableZoom(false);

    expandedController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {},
        onPageFinished: (x) async {},
      ),
    );
  }

  void expandeOrCollapseView() {
    isExpanded = !isExpanded;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.isNotEmpty) {
      if (isExpanded) {
        expandedController.loadRequest(Uri.parse(widget.url));
      } else {
        collapsedControle.loadRequest(Uri.parse(widget.url));
      }
    }

    return AnimatedContainer(
      height: isExpanded ? 425 : 105,
      decoration: const BoxDecoration(
        color: Color(0xFF282828),
      ),
      duration: Durations.short1,
      child: isExpanded ? _createViewExpanded() : _buildCollapsedView(),
    );
  }

  Widget _buildCollapsedView() {
    return Container(
      height: isExpanded ? 90 : 105,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Visibility(
            visible: !isExpanded,
            child: SizedBox(
              width: 125,
              height: 70,
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                child: WebViewWidget(
                  key: const Key('webView'),
                  controller: collapsedControle,
                ),
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCC0000),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const CustomText(
                            'AO VIVO',
                            fontWeight: FontWeight.w500,
                            fontSize: AppConstants.KFONTSIZE_12,
                            textColor: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Image.network(
                        widget.model?.live?.logo ?? '',
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: expandeOrCollapseView,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        isExpanded ? 'Reduzir' : 'Expandir',
                        fontWeight: FontWeight.w400,
                        textColor: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      isExpanded
                          ? SvgPicture.asset('assets/icons/collapsed_icon.svg')
                          : SvgPicture.asset('assets/icons/expand_icon.svg')
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _createViewExpanded() {
    return Column(
      children: [
        _buildCollapsedView(),
        Container(
          height: 220,
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.KPADDING_DEFAULT),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.hardEdge,
            child: WebViewWidget(
              key: const Key('webView1'),
              controller: expandedController,
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
                        widget.model?.live?.title ?? '',
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
                                widget.model?.live?.startTime?.hour ?? '',
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
                                  widget.model?.live?.presenter ?? '',
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.white,
                                  fontSize: AppConstants.KFONTSIZE_12,
                                  maxLines: 2,
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
                          widget.model?.next?.first.startTime?.hour ?? '',
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
                        widget.model?.next?.first.logo ??
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

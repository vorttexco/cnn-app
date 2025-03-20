// ignore_for_file: deprecated_member_use
import 'package:cnn_brasil_app/core/components/app_bar_webview.dart';
import 'package:cnn_brasil_app/core/extensions/string_extension.dart';
import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/core/models/article_gallery_model.dart';
import 'package:cnn_brasil_app/core/models/article_model.dart';
import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:cnn_brasil_app/features/article/article.dart';
import 'package:cnn_brasil_app/features/article/article_css.dart';
import 'package:cnn_brasil_app/features/article/article_settings.dart';
import 'package:cnn_brasil_app/features/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'article_view_model.dart';

class CounterProvider with ChangeNotifier {
  bool _isGalleryOpen = false;

  bool get isGalleryOpen => _isGalleryOpen;

  void changeValue() {
    _isGalleryOpen = !_isGalleryOpen;
    notifyListeners();
  }
}

class ArticleView extends ArticleViewModel {
  int currentIndex = 0;
  int currentEmbedIndex = 0;

  late InAppWebViewController collapsedControle;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _embedScrollController = ScrollController();

  List<Images> htmlImages = [];
  bool isGalleryOpen = false;
  bool onLoadInstragramEnded = false;

  final Map<String, double> customHeights = {};

  void _scrollToIndex(int index) {
    const itemWidth = 150.0;
    final offset = itemWidth * index;

    _scrollController.animateTo(
      offset,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToEmbedIndex(int index) {
    const itemWidth = 150.0;
    final offset = itemWidth * index;

    _embedScrollController.animateTo(
      offset,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _showGalleryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) {
        bool showImagesGrid = false;

        return Column(
          children: [
            IgnorePointer(
              ignoring: false,
              child: AppBarwebView(
                onFinished: () {
                  setState(() {});
                },
                title: 'Voltar',
                onIconPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);

                    // Future.delayed(const Duration(milliseconds: 200), () {
                    //   if (Navigator.canPop(context)) {
                    //     Navigator.pop(context);
                    //   }
                    // });
                  }
                },
                onShare: onShare,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xE6282828),
                  ),
                  height: MediaQuery.of(context).size.height - 110,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, bottom: 40.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showImagesGrid = !showImagesGrid;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: SvgPicture.network(
                                  !showImagesGrid
                                      ? 'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-grid.svg'
                                      : 'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!showImagesGrid) ...[
                          GestureDetector(
                            onHorizontalDragEnd: (details) {
                              double dragEndPosition =
                                  details.velocity.pixelsPerSecond.dx;
                              setState(() {
                                if (dragEndPosition > 0 && currentIndex > 0) {
                                  currentIndex--;
                                } else if (dragEndPosition < 0 &&
                                    currentIndex <
                                        articleGallery.images!.length - 1) {
                                  currentIndex++;
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Image.network(
                                    articleGallery.images![currentIndex].url!,
                                    height: 241,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "${currentIndex + 1} de ${articleGallery.images!.length}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'CNN Sans Display',
                                        fontFamilyFallback: [
                                          'HelveticaNeue',
                                          'Helvetica',
                                          'Arial',
                                          'Utkal',
                                          'sans-serif'
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: GestureDetector(
                                    onTap: () =>
                                        Navigator.pop(context, currentIndex),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: SvgPicture.network(
                                        'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                        placeholderBuilder: (context) =>
                                            const CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 74,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 24, right: 24),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: articleGallery
                                                  .images![currentIndex].caption
                                                  ?.stripHtml() ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'CNN Sans Display',
                                            fontFamilyFallback: [
                                              'HelveticaNeue',
                                              'Helvetica',
                                              'Arial',
                                              'Utkal',
                                              'sans-serif'
                                            ],
                                          ),
                                        ),
                                        if (articleGallery.images![currentIndex]
                                                    .credits !=
                                                null &&
                                            articleGallery.images![currentIndex]
                                                .credits!.isNotEmpty) ...[
                                          const TextSpan(
                                            text: ' • ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'CNN Sans Display',
                                              fontFamilyFallback: [
                                                'HelveticaNeue',
                                                'Helvetica',
                                                'Arial',
                                                'Utkal',
                                                'sans-serif'
                                              ],
                                            ),
                                          ),
                                          TextSpan(
                                            text: articleGallery
                                                .images![currentIndex].credits!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'CNN Sans Display',
                                              fontFamilyFallback: [
                                                'HelveticaNeue',
                                                'Helvetica',
                                                'Arial',
                                                'Utkal',
                                                'sans-serif'
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (currentIndex > 0) {
                                        setState(() {
                                          currentIndex--;
                                          _scrollToIndex(currentIndex);
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.chevron_left,
                                          color: Colors.white, size: 20),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  GestureDetector(
                                    onTap: () {
                                      if (currentIndex <
                                          articleGallery.images!.length - 1) {
                                        setState(() {
                                          currentIndex++;
                                          _scrollToIndex(currentIndex);
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.chevron_right,
                                          color: Colors.white, size: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                        if (showImagesGrid) ...[
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 172 / 96,
                              ),
                              itemCount: articleGallery.images!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentIndex = index;
                                      _scrollToIndex(index);
                                      showImagesGrid = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Image.network(
                                      articleGallery.images![index].url!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    ).then((newIndex) {
      if (newIndex != null) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
  }

  void _showEmbedGalleryModal(BuildContext context, Function setStateLocal) {
    setState(() {
      isGalleryOpen = true;
    });

    setStateLocal(() {});

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) {
        bool showImagesGrid = false;

        return Column(
          children: [
            AppBarwebView(
              onFinished: () {
                setState(() {});
              },
              title: 'Voltar',
              onIconPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);

                  // Future.delayed(const Duration(milliseconds: 200), () {
                  //   if (Navigator.canPop(context)) {
                  //     Navigator.pop(context);
                  //   }
                  // });
                }
              },
              onShare: onShare,
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xE6282828),
                  ),
                  height: MediaQuery.of(context).size.height - 110,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, bottom: 40.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showImagesGrid = !showImagesGrid;
                                });

                                setStateLocal(() {});
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: SvgPicture.network(
                                  !showImagesGrid
                                      ? 'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-grid.svg'
                                      : 'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!showImagesGrid) ...[
                          GestureDetector(
                            onHorizontalDragEnd: (details) {
                              double dragEndPosition =
                                  details.velocity.pixelsPerSecond.dx;
                              setState(() {
                                if (dragEndPosition > 0 &&
                                    currentEmbedIndex > 0) {
                                  currentEmbedIndex--;
                                } else if (dragEndPosition < 0 &&
                                    currentEmbedIndex < htmlImages.length - 1) {
                                  currentEmbedIndex++;
                                }
                              });

                              setStateLocal(() {});
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Image.network(
                                    htmlImages[currentEmbedIndex].url!,
                                    height: 241,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "${currentEmbedIndex + 1} de ${htmlImages.length}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'CNN Sans Display',
                                        fontFamilyFallback: [
                                          'HelveticaNeue',
                                          'Helvetica',
                                          'Arial',
                                          'Utkal',
                                          'sans-serif'
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(
                                        context, currentEmbedIndex),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: SvgPicture.network(
                                        'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                        placeholderBuilder: (context) =>
                                            const CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 74,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  left: 24,
                                  right: 24,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: htmlImages[currentEmbedIndex]
                                                .caption
                                                ?.stripHtml() ??
                                            '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CNN Sans Display',
                                          fontFamilyFallback: [
                                            'HelveticaNeue',
                                            'Helvetica',
                                            'Arial',
                                            'Utkal',
                                            'sans-serif'
                                          ],
                                        ),
                                      ),
                                      if (htmlImages[currentEmbedIndex]
                                                  .credits !=
                                              null &&
                                          htmlImages[currentEmbedIndex]
                                              .credits!
                                              .isNotEmpty) ...[
                                        const TextSpan(
                                          text: ' • ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'CNN Sans Display',
                                            fontFamilyFallback: [
                                              'HelveticaNeue',
                                              'Helvetica',
                                              'Arial',
                                              'Utkal',
                                              'sans-serif'
                                            ],
                                          ),
                                        ),
                                        TextSpan(
                                          text: htmlImages[currentEmbedIndex]
                                              .credits!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'CNN Sans Display',
                                            fontFamilyFallback: [
                                              'HelveticaNeue',
                                              'Helvetica',
                                              'Arial',
                                              'Utkal',
                                              'sans-serif'
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (currentEmbedIndex > 0) {
                                        setState(() {
                                          currentEmbedIndex--;
                                          _scrollToEmbedIndex(
                                              currentEmbedIndex);
                                        });

                                        setStateLocal(() {});
                                      }
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.chevron_left,
                                          color: Colors.white, size: 20),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  GestureDetector(
                                    onTap: () {
                                      if (currentEmbedIndex <
                                          htmlImages.length - 1) {
                                        setState(() {
                                          currentEmbedIndex++;
                                          _scrollToEmbedIndex(
                                              currentEmbedIndex);
                                        });

                                        setStateLocal(() {});
                                      }
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.chevron_right,
                                          color: Colors.white, size: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                        if (showImagesGrid) ...[
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 172 / 96,
                              ),
                              itemCount: htmlImages.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentEmbedIndex = index;
                                      _scrollToEmbedIndex(index);
                                      showImagesGrid = false;
                                    });

                                    setStateLocal(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Image.network(
                                      htmlImages[index].url!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    ).then((newIndex) {
      if (newIndex != null) {
        setState(() {
          currentEmbedIndex = newIndex;
          _scrollToEmbedIndex(newIndex);
          isGalleryOpen = false;
        });

        setStateLocal(() {});
      }
    });
  }

  void _showModal(BuildContext context, String imageUrl, String? caption) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) {
        return Column(
          children: [
            IgnorePointer(
              ignoring: false,
              child: AppBarwebView(
                onFinished: () {
                  setState(() {});
                },
                title: 'Voltar',
                onIconPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);

                    // Future.delayed(const Duration(milliseconds: 200), () {
                    //   if (Navigator.canPop(context)) {
                    //     Navigator.pop(context);
                    //   }
                    // });
                  }
                },
                onShare: onShare,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xE6282828),
                  ),
                  height: MediaQuery.of(context).size.height - 110,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Image.network(
                                imageUrl,
                                height: 241,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: SvgPicture.network(
                                    'https://www.cnnbrasil.com.br/wp-content/themes/master-theme/template-parts/single//content/assets/img/ico-exit.svg',
                                    placeholderBuilder: (context) =>
                                        const CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: RichText(
                            text: TextSpan(
                              text: caption ??
                                  article.featuredMedia!.image!.caption,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'CNN Sans Display',
                                fontFamilyFallback: [
                                  'HelveticaNeue',
                                  'Helvetica',
                                  'Arial',
                                  'Utkal',
                                  'sans-serif'
                                ],
                              ),
                              children: caption != null
                                  ? []
                                  : [
                                      TextSpan(
                                        text:
                                            ' • ${article.featuredMedia!.image!.credits}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> launchProfileInExternalBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // ignore: avoid_print
      print("Não foi possível abrir o link.");
    }
  }

  void _openInBrowser(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Ocorreu um erro ao abrir a URL: $url';
    }
  }

  Widget renderContent(String htmlSnippet) {
    final shouldRenderWebView = htmlSnippet.contains('flourish-embed') &&
        htmlSnippet.contains('data-src');

    if (shouldRenderWebView) {
      final match = RegExp(r'data-src="([^"]+)"').firstMatch(htmlSnippet);
      if (match != null) {
        final visualisationId = match.group(1);
        final visualisationUrl =
            'https://public.flourish.studio/$visualisationId/';

        return SizedBox(
          height: 480,
          width: double.infinity,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(visualisationUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              thirdPartyCookiesEnabled: true,
              cacheEnabled: true,
              transparentBackground: true,
            ),
            onWebViewCreated: (controller) async {
              final cookieManager = CookieManager.instance();

              await cookieManager.setCookie(
                url: WebUri("https://public.flourish.studio"),
                name: "cookie_consent",
                value: "accepted",
                domain: ".flourish.studio",
              );

              controller.reload();
            },
          ),
        );
      }
    }

    return const Center();
  }

  ArticleTags? get featuredTag {
    if (article.content != null &&
        article.tags != null &&
        article.tags!.isNotEmpty &&
        article.tags!.any((x) => x.picture?.enabled == true)) {
      return article.tags!.firstWhere((x) => x.picture?.enabled == true);
    }

    return null;
  }

  String get renderedAuthor {
    if (article.author?.rendered == null ||
        article.author!.list?.isEmpty == true) {
      return '';
    }

    final lastName = article.author!.list!.last.name;
    if (lastName == null || lastName.isEmpty) return '';

    final index = article.author!.rendered!.lastIndexOf(lastName);

    if (index == -1) return article.author!.rendered!.trim();

    var resp = article.author!.rendered!.substring(index + lastName.length);

    if (resp.startsWith(',')) {
      resp = resp.substring(1);
    }

    return ' ${resp.trim()}';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarwebView(
              onFinished: () {
                setState(() {});
              },
              title: 'Voltar',
              onIconPressed: onBack,
              onShare: onShare,
            ),
            // Container(
            //   constraints: const BoxConstraints(maxHeight: 150),
            //   alignment: Alignment.center,
            //   child: InAppWebView(
            //     initialUrlRequest: URLRequest(
            //       url: WebUri("https://www.cnnbrasil.com.br/ads-only-page/?ad_id=stick")
            //     ),
            //     onLoadStop: (controller, url) {
            //       Color bgColor = Theme.of(context).scaffoldBackgroundColor;

            //       String bgColorCss = "rgb(${bgColor.red}, ${bgColor.green}, ${bgColor.blue})";

            //       controller.evaluateJavascript(source: """
            //         (function() {
            //           let observer = new MutationObserver((mutations, obs) => {
            //             let adArea = document.querySelector(".ad__area.ad__area--only");
            //             if (adArea) {
            //               adArea.style.background = "$bgColorCss";
            //               obs.disconnect();
            //             }
            //           });

            //           observer.observe(document.body, { childList: true, subtree: true });
            //         })();
            //       """);
            //     },
            //     shouldOverrideUrlLoading: (controller, navigationAction) async {
            //       Uri uri = Uri.parse(navigationAction.request.url.toString());

            //       if (uri.host.contains("adclick") || uri.host.contains("googleads.g.doubleclick.net")) {
            //         _openInBrowser(uri.toString());

            //         return NavigationActionPolicy.CANCEL;
            //       }

            //       return NavigationActionPolicy.ALLOW;
            //     },
            //   ),
            // ),
            const SizedBox(height: AppConstants.KPADDING_8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (fetched && article.content?.content != null) ...[
                      if ((articleType == "Blog" || articleType == "Coluna") &&
                          article.author != null &&
                          article.author!.list != null &&
                          article.author!.list!.isNotEmpty) ...[
                        SizedBox(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  'https://www.cnnbrasil.com.br/wp-content/client-mu-plugins/cnn-blogs/img/cnn-bg-coluna.webp',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                        height: 168,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: articleType == "Blog" ? Image.network(article.author!
                                                  .list!.first.pictures!.blog ??
                                              "") : Image.network(article.author!
                                                  .list!.first.pictures!.columns ??
                                              ""),
                                        )),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 6),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 8),
                                              child: Text(
                                                articleType,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontFamily:
                                                      'CNN Sans Display',
                                                  fontFamilyFallback: const [
                                                    'HelveticaNeue',
                                                    'Helvetica',
                                                    'Arial',
                                                    'Utkal',
                                                    'sans-serif'
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            article.author!.list!.first.name
                                                    ?.replaceAll(
                                                        "&#039;", "'") ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontFamily: 'CNN Sans Display',
                                              fontFamilyFallback: [
                                                'HelveticaNeue',
                                                'Helvetica',
                                                'Arial',
                                                'Utkal',
                                                'sans-serif'
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            article.author!.list!.first.bio
                                                    ?.replaceAll(
                                                        "&#039;", "'") ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontFamily: 'CNN Sans Display',
                                              fontFamilyFallback: [
                                                'HelveticaNeue',
                                                'Helvetica',
                                                'Arial',
                                                'Utkal',
                                                'sans-serif'
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Wrap(
                                            spacing: 16,
                                            runSpacing: 8,
                                            alignment: WrapAlignment.start,
                                            children: [
                                              if (article.author!.list!.first
                                                          .social?.instagram !=
                                                      "" &&
                                                  article.author!.list!.first
                                                          .social?.instagram !=
                                                      null) ...[
                                                _buildSocialIcon(
                                                    article.author!.list!.first
                                                        .social?.instagram,
                                                    'https://www.cnnbrasil.com.br/wp-content/client-mu-plugins/cnn-blogs/img/instagram_cnn.svg'),
                                              ],
                                              if (article.author!.list!.first
                                                          .social?.twitter !=
                                                      "" &&
                                                  article.author!.list!.first
                                                          .social?.twitter !=
                                                      null) ...[
                                                _buildSocialIcon(
                                                    article.author!.list!.first
                                                        .social?.twitter,
                                                    'https://www.cnnbrasil.com.br/wp-content/client-mu-plugins/cnn-blogs/img/x_twitter_cnn.svg'),
                                              ],
                                              if (article.author!.list!.first
                                                          .social?.linkedin !=
                                                      "" &&
                                                  article.author!.list!.first
                                                          .social?.linkedin !=
                                                      null) ...[
                                                _buildSocialIcon(
                                                    article.author!.list!.first
                                                        .social?.linkedin,
                                                    'https://www.cnnbrasil.com.br/wp-content/client-mu-plugins/cnn-blogs/img/linkedin_cnn.svg'),
                                              ],
                                              if (article.author!.list!.first
                                                          .social?.youtube !=
                                                      "" &&
                                                  article.author!.list!.first
                                                          .social?.youtube !=
                                                      null) ...[
                                                _buildSocialIcon(
                                                    article.author!.list!.first
                                                        .social?.youtube,
                                                    'https://www.cnnbrasil.com.br/wp-content/client-mu-plugins/cnn-blogs/img/youtube_cnn.svg'),
                                              ],
                                              if (article.author!.list!.first
                                                          .social?.tiktok !=
                                                      "" &&
                                                  article.author!.list!.first
                                                          .social?.tiktok !=
                                                      null) ...[
                                                _buildSocialIcon(
                                                    article.author!.list!.first
                                                        .social?.tiktok,
                                                    'https://www.cnnbrasil.com.br/wp-content/client-mu-plugins/cnn-blogs/img/tiktok_cnn.svg'),
                                              ],
                                              InkWell(
                                                onTap: () {
                                                  Clipboard.setData(ClipboardData(
                                                      text:
                                                          articleUrl.replaceAll(
                                                              "?hidemenu=true",
                                                              "")));
                                                },
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                24)),
                                                  ),
                                                  child: SvgPicture.network(
                                                    'https://www.cnnbrasil.com.br/wp-content/client-mu-plugins/cnn-blogs/img/link_cnn.svg',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (featuredTag != null) ...[
                              featuredTag!.picture!.url!.contains('.svg')
                                  ? SvgPicture.network(
                                      featuredTag!.picture!.url!)
                                  : Image.network(featuredTag!.picture!.url!)
                            ],
                            const SizedBox(height: AppConstants.KPADDING_24),
                            Text(
                              article.title
                                      ?.replaceAll("&quot;", '"')
                                      .replaceAll("&#039;", "'") ??
                                  '',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 26,
                                height: 33 / 26,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'CNN Sans Display',
                                fontFamilyFallback: const [
                                  'HelveticaNeue',
                                  'Helvetica',
                                  'Arial',
                                  'Utkal',
                                  'sans-serif'
                                ],
                              ),
                            ),
                            Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                            ),
                            Text(
                              article.excerpt?.replaceAll("&quot;", '"') ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'CNN Sans Display',
                                fontFamilyFallback: const [
                                  'HelveticaNeue',
                                  'Helvetica',
                                  'Arial',
                                  'Utkal',
                                  'sans-serif'
                                ],
                              ),
                            ),
                            const SizedBox(height: AppConstants.KPADDING_16),
                            if (article.author?.list != null &&
                                articleType != "Blog" &&
                                articleType != "Coluna")
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'CNN Sans Display',
                                    fontFamilyFallback: const [
                                      'HelveticaNeue',
                                      'Helvetica',
                                      'Arial',
                                      'Utkal',
                                      'sans-serif'
                                    ],
                                  ),
                                  children: [
                                    for (var author
                                        in article.author!.list!) ...[
                                      TextSpan(
                                        text: '${author.name}',
                                        style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          fontFamily: 'CNN Sans Display',
                                          fontFamilyFallback: [
                                            'HelveticaNeue',
                                            'Helvetica',
                                            'Arial',
                                            'Utkal',
                                            'sans-serif'
                                          ],
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            if (author.permalink != null) {
                                              NavigatorManager(context).to(
                                                  CustomWebView.route,
                                                  data: WebviewNavigatorModel(
                                                      url:
                                                          '${author.permalink!}?hidemenu=true',
                                                      title: 'Voltar'),
                                                  onFinished: () {},
                                                  analytics: NavigatorAnalytics
                                                      .fromUrl(
                                                    author.permalink!,
                                                  ));
                                            }
                                          },
                                      ),
                                      if (article.author!.list!
                                                  .indexOf(author) ==
                                              (article.author!.list!.length -
                                                  2) &&
                                          article.author!.list!.length > 1)
                                        const TextSpan(
                                          text: ' e ',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            fontFamily: 'CNN Sans Display',
                                            fontFamilyFallback: [
                                              'HelveticaNeue',
                                              'Helvetica',
                                              'Arial',
                                              'Utkal',
                                              'sans-serif'
                                            ],
                                          ),
                                        )
                                      else if (article.author!.list!.length > 1)
                                        const TextSpan(
                                          text: ', ',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            fontFamily: 'CNN Sans Display',
                                            fontFamilyFallback: [
                                              'HelveticaNeue',
                                              'Helvetica',
                                              'Arial',
                                              'Utkal',
                                              'sans-serif'
                                            ],
                                          ),
                                        )
                                    ],
                                    if (renderedAuthor != '')
                                      TextSpan(
                                        text: renderedAuthor,
                                        style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          fontFamily: 'CNN Sans Display',
                                          fontFamilyFallback: [
                                            'HelveticaNeue',
                                            'Helvetica',
                                            'Arial',
                                            'Utkal',
                                            'sans-serif'
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: AppConstants.KPADDING_16),
                            Text(
                              "${formatDateTime(article.publishDate!)}${article.modifiedDate != null && article.modifiedDate!.isNotEmpty && formatDateTime(article.modifiedDate!) != formatDateTime(article.publishDate!) ? " | Atualizado ${formatDateTime(article.modifiedDate!)}" : ""}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'CNN Sans Display',
                                fontFamilyFallback: const [
                                  'HelveticaNeue',
                                  'Helvetica',
                                  'Arial',
                                  'Utkal',
                                  'sans-serif'
                                ],
                              ),
                            ),
                            const SizedBox(height: AppConstants.KPADDING_8),
                            if (article.featuredMedia?.video != null) ...[
                              const SizedBox(height: AppConstants.KPADDING_8),
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: InAppWebView(
                                  key: const Key('webView'),
                                  initialUrlRequest: URLRequest(
                                      url: WebUri(
                                          '${ApiHome.home}/youtube/video/?youtube_id=${article.featuredMedia?.video?.id}&youtube_adformat=aovivo&hidemenu=true&youtube_mode=teatro')),
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
                                    collapsedControle = controller;
                                  },
                                  onLoadStop: (controller, url) async {
                                    await controller
                                        .evaluateJavascript(source: """
                                  var video = document.querySelector('video');
                                  if (video) {
                                    video.style.width = '100%';
                                    video.style.height = '100%';
                                    video.play();
                                  }
                                  """);
                                  },
                                ),
                              ),
                              const SizedBox(height: AppConstants.KPADDING_8),
                            ],
                            if (articleGallery.images != null &&
                                articleGallery.images!.isNotEmpty &&
                                article.featuredMedia?.video == null) ...[
                              Column(
                                children: [
                                  const SizedBox(
                                      height: AppConstants.KPADDING_8),
                                  GestureDetector(
                                    onHorizontalDragEnd: (details) {
                                      double dragEndPosition =
                                          details.velocity.pixelsPerSecond.dx;

                                      if (dragEndPosition > 0) {
                                        setState(() {
                                          if (currentIndex > 0) {
                                            currentIndex--;
                                            _scrollToIndex(currentIndex);
                                          }
                                        });
                                      } else if (dragEndPosition < 0) {
                                        setState(() {
                                          if (currentIndex <
                                              articleGallery.images!.length -
                                                  1) {
                                            currentIndex++;
                                            _scrollToIndex(currentIndex);
                                          }
                                        });
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.black),
                                          child: Image.network(
                                            articleGallery
                                                .images![currentIndex].url!,
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: 16,
                                            left: 16,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                "${currentIndex + 1} de ${articleGallery.images!.length}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      'CNN Sans Display',
                                                  fontFamilyFallback: [
                                                    'HelveticaNeue',
                                                    'Helvetica',
                                                    'Arial',
                                                    'Utkal',
                                                    'sans-serif'
                                                  ],
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                            top: 16,
                                            right: 16,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  _showGalleryModal(context),
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                child: SvgPicture.network(
                                                  'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                                  placeholderBuilder: (context) =>
                                                      const CircularProgressIndicator(),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                          bottom: 0,
                                          child: Container(
                                            height: 192,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.only(
                                                left: 24,
                                                right: 24,
                                                bottom: 16),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.black.withOpacity(1),
                                                  Colors.black.withOpacity(0),
                                                ],
                                                stops: const [0.38, 0.59],
                                              ),
                                            ),
                                            alignment: Alignment.bottomLeft,
                                            child: SizedBox(
                                              height: 74,
                                              child: Scrollbar(
                                                controller: ScrollController(),
                                                thumbVisibility: true,
                                                trackVisibility: true,
                                                thickness: 6,
                                                radius:
                                                    const Radius.circular(8),
                                                scrollbarOrientation:
                                                    ScrollbarOrientation.right,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 16, top: 2),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: articleGallery
                                                                    .images![
                                                                        currentIndex]
                                                                    .caption
                                                                    ?.stripHtml() ??
                                                                '',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'CNN Sans Display',
                                                              fontFamilyFallback: [
                                                                'HelveticaNeue',
                                                                'Helvetica',
                                                                'Arial',
                                                                'Utkal',
                                                                'sans-serif'
                                                              ],
                                                            ),
                                                          ),
                                                          if (articleGallery
                                                                      .images![
                                                                          currentIndex]
                                                                      .credits !=
                                                                  null &&
                                                              articleGallery
                                                                  .images![
                                                                      currentIndex]
                                                                  .credits!
                                                                  .isNotEmpty) ...[
                                                            const TextSpan(
                                                              text: ' • ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    'CNN Sans Display',
                                                                fontFamilyFallback: [
                                                                  'HelveticaNeue',
                                                                  'Helvetica',
                                                                  'Arial',
                                                                  'Utkal',
                                                                  'sans-serif'
                                                                ],
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: articleGallery
                                                                  .images![
                                                                      currentIndex]
                                                                  .credits!,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'CNN Sans Display',
                                                                fontFamilyFallback: [
                                                                  'HelveticaNeue',
                                                                  'Helvetica',
                                                                  'Arial',
                                                                  'Utkal',
                                                                  'sans-serif'
                                                                ],
                                                              ),
                                                            )
                                                          ]
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                ],
                              ),
                              SizedBox(
                                height: 85,
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int index = 0;
                                          index < articleGallery.images!.length;
                                          index++)
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentIndex = index;
                                              _scrollToIndex(index);
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 1.5),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  articleGallery
                                                      .images![index].url!,
                                                  width: 150,
                                                  height: 85,
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    height: 7,
                                                    color: index == currentIndex
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.transparent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppConstants.KPADDING_8),
                            ],
                            if (article.featuredMedia?.image != null &&
                                articleGallery.images == null &&
                                article.featuredMedia?.video == null) ...[
                              Stack(
                                children: [
                                  Image.network(
                                      article.featuredMedia!.image!.url!),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: GestureDetector(
                                      onTap: () => _showModal(
                                          context,
                                          article.featuredMedia!.image!.url!,
                                          null),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: SvgPicture.network(
                                          'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                          placeholderBuilder: (context) =>
                                              const CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppConstants.KPADDING_8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: RichText(
                                  text: TextSpan(
                                    text: article.featuredMedia!.image!.caption,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'CNN Sans Display',
                                      fontFamilyFallback: const [
                                        'HelveticaNeue',
                                        'Helvetica',
                                        'Arial',
                                        'Utkal',
                                        'sans-serif'
                                      ],
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' • ${article.featuredMedia!.image!.credits}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppConstants.KPADDING_8),
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                              // if (article!.permalink != null) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 10, vertical: 2),
                              //     child: InkWell(
                              //       onTap: () =>
                              //           Share.shareUri(Uri.parse(article!.permalink!)),
                              //       child: SizedBox(
                              //         height: 40,
                              //         child: Row(
                              //           children: [
                              //             Container(
                              //               width: 40,
                              //               height: 40,
                              //               decoration: BoxDecoration(
                              //                 color: Theme.of(context).primaryColor,
                              //                 shape: BoxShape.circle,
                              //               ),
                              //               padding: const EdgeInsets.only(right: 3),
                              //               child: const Icon(
                              //                 Icons.share,
                              //                 color: Colors.white,
                              //                 size: 25,
                              //               ),
                              //             ),
                              //             const SizedBox(width: 10),
                              //             Text(
                              //               'Compartilhar matéria',
                              //               style: TextStyle(
                              //                 color: Theme.of(context).colorScheme.primary,
                              //                 fontSize: 14,
                              //               ),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              //   const Padding(
                              //     padding: EdgeInsets.symmetric(horizontal: 10),
                              //     child: Divider(),
                              //   ),
                              // ]
                            ],
                            HtmlWidget(
                              article.content!.content!.replaceAll('"', '"'),
                              textStyle: TextStyle(
                                fontFamily: 'CNN Sans Display',
                                fontFamilyFallback: const [
                                  'HelveticaNeue',
                                  'Helvetica',
                                  'Arial',
                                  'Utkal',
                                  'sans-serif'
                                ],
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onTapUrl: (url) {
                                if (url.endsWith('/')) {
                                  url = url.substring(0, url.length - 1);
                                }

                                final articleId = url
                                    .replaceAll('/?', '?')
                                    .split('?')
                                    .first
                                    .split('/')
                                    .last;

                                if (articleId.characters.length > 15) {
                                  NavigatorManager(context).to(
                                    Article.route,
                                    data: ArticleSettings(
                                        articleId: articleId, articleUrl: url),
                                    onFinished: () {},
                                  );

                                  return true;
                                } else {
                                  if (!url.contains('${ApiHome.home}/?s=') &&
                                      url.contains(ApiHome.home)) {
                                    NavigatorManager(context).to(
                                      CustomWebView.route,
                                      data: WebviewNavigatorModel(
                                          url: url, title: 'Voltar'),
                                      onFinished: () {},
                                      analytics:
                                          NavigatorAnalytics.fromUrl(url),
                                    );

                                    return true;
                                  }
                                }

                                return false;
                              },
                              rebuildTriggers: customHeights.keys.toList(),
                              customStylesBuilder: (element) => cssBuilder(
                                  element,
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).primaryColor,
                                  Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer),
                              customWidgetBuilder: (element) {
                                // if (element.localName == 'div' && element.classes.contains('custom__ad__element')) {
                                //   String? divId = element.id;

                                //   return Container(
                                //     constraints: const BoxConstraints(maxHeight: 350),
                                //     alignment: Alignment.center,
                                //     child: InAppWebView(
                                //       initialUrlRequest: URLRequest(
                                //         url: WebUri("https://www.cnnbrasil.com.br/ads-only-page/?ad_id=$divId")
                                //       ),
                                //       onLoadStop: (controller, url) {
                                //         Color bgColor = Theme.of(context).scaffoldBackgroundColor;

                                //         String bgColorCss = "rgb(${bgColor.red}, ${bgColor.green}, ${bgColor.blue})";

                                //         controller.evaluateJavascript(source: """
                                //           (function() {
                                //             let observer = new MutationObserver((mutations, obs) => {
                                //               let adArea = document.querySelector(".ad__area.ad__area--only");
                                //               if (adArea) {
                                //                 adArea.style.background = "$bgColorCss";
                                //                 obs.disconnect();
                                //               }
                                //             });

                                //             observer.observe(document.body, { childList: true, subtree: true });
                                //           })();
                                //         """);
                                //       },
                                //       shouldOverrideUrlLoading: (controller, navigationAction) async {
                                //         Uri uri = Uri.parse(navigationAction.request.url.toString());

                                //         if (uri.host.contains("adclick") || uri.host.contains("googleads.g.doubleclick.net")) {
                                //           _openInBrowser(uri.toString());
                                //           return NavigationActionPolicy.CANCEL;
                                //         }

                                //         return NavigationActionPolicy.ALLOW;
                                //       },
                                //     ),
                                //   );
                                // }

                                if (element.localName == 'figure' &&
                                    element.classes
                                        .contains('fullscreen-wrapper')) {
                                  var imgElement = element.children.firstWhere(
                                      (child) => child.localName == 'img');

                                  var src = imgElement.attributes['src'];

                                  var figcaptionElement = element.children
                                      .firstWhere((child) =>
                                          child.localName == 'figcaption');

                                  var figcaptionText = figcaptionElement.text;

                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(src!),
                                          Positioned(
                                            top: 16,
                                            right: 16,
                                            child: GestureDetector(
                                              onTap: () => _showModal(
                                                  context, src, figcaptionText),
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                child: SvgPicture.network(
                                                  'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                                  placeholderBuilder: (context) =>
                                                      const CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height: AppConstants.KPADDING_8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: RichText(
                                          text: TextSpan(
                                            text: figcaptionText,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'CNN Sans Display',
                                              fontFamilyFallback: const [
                                                'HelveticaNeue',
                                                'Helvetica',
                                                'Arial',
                                                'Utkal',
                                                'sans-serif'
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: AppConstants.KPADDING_8),
                                    ],
                                  );
                                }

                                if (element.classes
                                        .contains('flourish-embed') &&
                                    element.attributes
                                        .containsKey('data-src')) {
                                  final visualisationUrl =
                                      'https://public.flourish.studio/${element.attributes['data-src']}/';

                                  final key = GlobalKey<_DynamicWebViewState>();

                                  final mapKey = element.id + element.className;

                                  if (customHeights[mapKey] != null) {
                                    late InAppWebViewController webViewCorrectFlourishController;

                                    final visualisationUrlCorrect = 'https://flo.uri.sh/${element.attributes['data-src']}/embed';

                                    return SizedBox(
                                      width: double.infinity,
                                      height: customHeights[mapKey],
                                      child: InAppWebView(
                                        initialUrlRequest: URLRequest(url: WebUri(visualisationUrlCorrect)),
                                        initialSettings: InAppWebViewSettings(
                                          javaScriptEnabled: true,
                                          thirdPartyCookiesEnabled: true,
                                          cacheEnabled: true,
                                          transparentBackground: true,
                                        ),
                                        onWebViewCreated: (controller) async {
                                          webViewCorrectFlourishController = controller;
                                          final cookieManager = CookieManager.instance();
                                      
                                          await cookieManager.setCookie(
                                            url: WebUri(visualisationUrlCorrect),
                                            name: "OptanonAlertBoxClosed",
                                            value: "2025-02-26T08:47:35.404Z",
                                            domain: "public.flourish.studio",
                                          );
                                      
                                          await cookieManager.setCookie(
                                            url: WebUri(visualisationUrlCorrect),
                                            name: "OptanonConsent",
                                            value:
                                                "isGpcEnabled=0&datestamp=Wed+Feb+26+2025+05%3A47%3A35+GMT-0300+(Brasilia+Standard+Time)&version=202301.2.0&isIABGlobal=false&hosts=&landingPath=NotLandingPage&groups=C0001%3A1%2CC0002%3A1%2CC0003%3A1%2CC0004%3A1&AwaitingReconsent=false",
                                            domain: ".flourish.studio",
                                          );
                                      
                                          webViewCorrectFlourishController.reload();
                                        }
                                      ),
                                    );
                                  }

                                  return SizedBox(
                                    width: double.infinity,
                                    height: customHeights[mapKey] ?? 600,
                                    child: DynamicWebView(
                                      key: key,
                                      visualisationUrl: visualisationUrl,
                                      onHeightUpdate: (newHeight) {
                                        setState(() {
                                          customHeights[mapKey] = newHeight;
                                        });
                                      },
                                      webViewHeight: customHeights[mapKey],
                                    ),
                                  );
                                }

                                if (element.classes
                                        .contains('instagram-media') &&
                                    element.attributes.containsKey(
                                        "data-instgrm-permalink")) {
                                  var instagramEmbedUrl = element
                                      .attributes['data-instgrm-permalink']!;

                                  final regex = RegExp(r"reel/([^/?]+)");
                                  final match =
                                      regex.firstMatch(instagramEmbedUrl);

                                  var finalInstagramUrl = instagramEmbedUrl;

                                  if (match != null) {
                                    finalInstagramUrl =
                                        "https://www.instagram.com/p/${match.group(1)}/embed/captioned/?cr=1&v=14&wp=54";
                                  }

                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: const Color(0xFFDBDBDB)),
                                      boxShadow: const [],
                                    ),
                                    child: SizedBox(
                                      height: 975,
                                      child: InAppWebView(
                                        initialUrlRequest: URLRequest(
                                            url: WebUri(finalInstagramUrl),
                                            headers: {
                                              'User-Agent':
                                                  'Mozilla/5.0 (Linux; Android 10; Pixel 4 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.101 Mobile Safari/537.36',
                                            }),
                                        initialSettings: InAppWebViewSettings(
                                          useWideViewPort: true,
                                          supportZoom: false,
                                          mediaPlaybackRequiresUserGesture:
                                              false,
                                          javaScriptEnabled: true,
                                        ),
                                        onLoadStop: (controller, url) {
                                          setState(() {
                                            onLoadInstragramEnded = true;
                                          });
                                        },
                                        shouldOverrideUrlLoading: (controller,
                                            navigationAction) async {
                                          final uri =
                                              navigationAction.request.url!;

                                          if (uri.toString().startsWith(
                                                  'https://www.instagram.com') &&
                                              onLoadInstragramEnded) {
                                            launchUrl(uri);
                                            return NavigationActionPolicy
                                                .CANCEL;
                                          }

                                          return NavigationActionPolicy.ALLOW;
                                        },
                                      ),
                                    ),
                                  );
                                }

                                if (element.classes
                                    .contains('read-too__link')) {
                                  final imageUrl = element
                                      .querySelector('img')
                                      ?.attributes['src'];
                                  final title =
                                      element.querySelector('h3')?.text ?? '';

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          String url =
                                              element.attributes['href'] ?? '';

                                          if (url.endsWith('/')) {
                                            url = url.substring(
                                                0, url.length - 1);
                                          }

                                          final articleId = url
                                              .replaceAll('/?', '?')
                                              .split('?')
                                              .first
                                              .split('/')
                                              .last;

                                          if (articleId.characters.length >
                                              15) {
                                            NavigatorManager(context).to(
                                              Article.route,
                                              data: ArticleSettings(
                                                  articleId: articleId,
                                                  articleUrl: url),
                                              onFinished: () {},
                                            );
                                          } else {
                                            if (!url.contains(
                                                    '${ApiHome.home}/?s=') &&
                                                url.contains(ApiHome.home)) {
                                              NavigatorManager(context).to(
                                                CustomWebView.route,
                                                data: WebviewNavigatorModel(
                                                    url: url, title: 'Voltar'),
                                                onFinished: () {},
                                                analytics:
                                                    NavigatorAnalytics.fromUrl(
                                                        url),
                                              );
                                            }
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            imageUrl != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 16.0),
                                                    child: Image.network(
                                                      imageUrl,
                                                      height: 80,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(),
                                            Expanded(
                                              child: Text(
                                                title.trim(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  height: 20 / 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      'CNN Sans Display',
                                                  fontFamilyFallback: [
                                                    'HelveticaNeue',
                                                    'Helvetica',
                                                    'Arial',
                                                    'Utkal',
                                                    'sans-serif'
                                                  ],
                                                ),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (element.classes
                                    .contains('read-too__title')) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            element.text,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontFamily: 'CNN Sans Display',
                                              fontFamilyFallback: const [
                                                'HelveticaNeue',
                                                'Helvetica',
                                                'Arial',
                                                'Utkal',
                                                'sans-serif'
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Transform.translate(
                                            offset: const Offset(0, 1.5),
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  );
                                }

                                if (element.localName == 'hr') {
                                  return Container();
                                }

                                if (element.localName == 'iframe' &&
                                    (element.attributes.containsKey('src') ||
                                        element.attributes
                                            .containsKey('data-src'))) {
                                  var dataSrc = element.attributes['data-src'];

                                  if (dataSrc != null &&
                                      dataSrc.contains(
                                          'stories.cnnbrasil.com.br') &&
                                      dataSrc.contains('/embed/')) {
                                    dataSrc =
                                        dataSrc.replaceAll("/embed/", "/");
                                  }

                                  if (dataSrc != null &&
                                      dataSrc.contains(
                                          'stories.cnnbrasil.com.br')) {
                                    late WebViewController webViewController;

                                    webViewController = WebViewController()
                                      ..setJavaScriptMode(
                                          JavaScriptMode.unrestricted)
                                      ..setUserAgent(
                                          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36") // Configura o User-Agent
                                      ..loadRequest(Uri.parse(dataSrc));

                                    return SizedBox(
                                      height: 650,
                                      child: Stack(
                                        children: [
                                          WebViewWidget(
                                            controller: webViewController,
                                            gestureRecognizers: <Factory<
                                                OneSequenceGestureRecognizer>>{
                                              Factory<
                                                  OneSequenceGestureRecognizer>(
                                                () => EagerGestureRecognizer(),
                                              ),
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              NavigatorManager(context).modal(
                                                StorieDetail(
                                                  url:
                                                      '$dataSrc/?hidemenu=true',
                                                ),
                                                fullscreenDialog: true,
                                              );
                                            },
                                            child: const SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }

                                  if (dataSrc != null &&
                                      dataSrc.contains(
                                          'https://www.riddle.com/embed/')) {
                                    return SizedBox(
                                      height: 912,
                                      child: InAppWebView(
                                        initialUrlRequest: URLRequest(
                                          url: WebUri(dataSrc),
                                          headers: {
                                            'User-Agent':
                                                'Mozilla/5.0 (Linux; Android 10; Pixel 4 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.101 Mobile Safari/537.36',
                                          },
                                        ),
                                      ),
                                    );
                                  }

                                  return SizedBox(
                                    height: 400,
                                    child: InAppWebView(
                                      initialUrlRequest: URLRequest(
                                        url: WebUri(element.attributes['src'] ??
                                            dataSrc!),
                                      ),
                                    ),
                                  );
                                }

                                if (element.attributes
                                    .containsKey('data-youtube-id')) {
                                  String? youtubeId =
                                      element.attributes['data-youtube-id'];

                                  var url =
                                      "${ApiHome.home}/youtube/video/?youtube_id=$youtubeId&youtube_adformat=aovivo&hidemenu=true&youtube_mode=teatro";

                                  return SizedBox(
                                    height: 224,
                                    child: InAppWebView(
                                      initialUrlRequest: URLRequest(
                                        url: WebUri(url),
                                      ),
                                    ),
                                  );
                                }

                                if (element.localName == 'a' &&
                                    element.parent?.localName == 'h2') {
                                  return Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    child: InkWell(
                                      onTap: () {
                                        String url =
                                            element.attributes['href'] ?? '';

                                        if (url.endsWith('/')) {
                                          url =
                                              url.substring(0, url.length - 1);
                                        }

                                        final articleId = url
                                            .replaceAll('/?', '?')
                                            .split('?')
                                            .first
                                            .split('/')
                                            .last;

                                        if (articleId.characters.length > 15) {
                                          NavigatorManager(context).to(
                                            Article.route,
                                            data: ArticleSettings(
                                                articleId: articleId,
                                                articleUrl: url),
                                            onFinished: () {},
                                          );
                                        } else {
                                          if (!url.contains(
                                                  '${ApiHome.home}/?s=') &&
                                              url.contains(ApiHome.home)) {
                                            NavigatorManager(context).to(
                                              CustomWebView.route,
                                              data: WebviewNavigatorModel(
                                                  url: url, title: 'Voltar'),
                                              onFinished: () {},
                                              analytics:
                                                  NavigatorAnalytics.fromUrl(
                                                      url),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        element.text,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).primaryColor,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Theme.of(context).primaryColor,
                                          fontFamily: 'CNN Sans Display',
                                          fontFamilyFallback: const [
                                            'HelveticaNeue',
                                            'Helvetica',
                                            'Arial',
                                            'Utkal',
                                            'sans-serif'
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (element.localName == "h2") {
                                  final nextElement =
                                      element.nextElementSibling;
                                  var titleText = element.text;

                                  if (nextElement?.localName == 'p') {
                                    var nextDiv =
                                        nextElement?.nextElementSibling;

                                    if (nextDiv != null &&
                                        nextDiv.localName == 'div' &&
                                        nextDiv.classes
                                            .contains('post__video')) {
                                      return Container(
                                        padding: EdgeInsets.zero,
                                        margin: EdgeInsets.zero,
                                        child: Text(
                                          titleText,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'CNN Sans Display',
                                            fontFamilyFallback: [
                                              'HelveticaNeue',
                                              'Helvetica',
                                              'Arial',
                                              'Utkal',
                                              'sans-serif'
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }

                                  return Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    child: Text(
                                      titleText,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'CNN Sans Display',
                                        fontFamilyFallback: [
                                          'HelveticaNeue',
                                          'Helvetica',
                                          'Arial',
                                          'Utkal',
                                          'sans-serif'
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (element.classes.contains('twitter-tweet')) {
                                  var htmlContent = element.outerHtml;

                                  htmlContent = '''
                                    <html>
                                      <head>
                                        <meta name="viewport" content="width=device-width, initial-scale=1">
                                      </head>
                                      $htmlContent
                                      <p><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></p>
                                    </html>
                                  ''';

                                  final key = GlobalKey<_DynamicTwitterWebViewState>();

                                  final mapKey = element.id + element.className;

                                  return SizedBox(
                                    width: double.infinity,
                                    height: customHeights[mapKey] ?? 10,
                                    child: DynamicTwitterWebView(
                                      key: key,
                                      visualisationUrl: htmlContent,
                                      onHeightUpdate: (newHeight) {
                                        setState(() {
                                          customHeights[mapKey] = newHeight;
                                        });
                                      },
                                      webViewHeight: customHeights[mapKey],
                                    ),
                                  );

                                  // return Container(
                                  //   width: double.infinity,
                                  //   constraints:
                                  //       const BoxConstraints(maxHeight: 1500),
                                  //   child: InAppWebView(
                                  //     initialData: InAppWebViewInitialData(
                                  //         data: htmlContent),
                                  //     initialOptions: InAppWebViewGroupOptions(
                                  //       crossPlatform: InAppWebViewOptions(
                                  //           javaScriptEnabled: true,
                                  //           mediaPlaybackRequiresUserGesture:
                                  //               false,
                                  //           userAgent:
                                  //               "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
                                  //           supportZoom: true),
                                  //     ),
                                  //   ),
                                  // );
                                }

                                if (element.classes
                                        .contains('thumbnail-image') ||
                                    element.classes.contains("video-title")) {
                                  return Container(height: 0);
                                }

                                if (element.classes.contains('gallery') &&
                                    element.classes
                                        .contains('gallery--content')) {
                                  var galleryItems = element
                                      .querySelectorAll('.gallery__item');

                                  for (var item in galleryItems) {
                                    var imgElement =
                                        item.querySelector('.gallery__img');
                                    var descriptionElement = item.querySelector(
                                        '.gallery__description p');

                                    if (imgElement != null &&
                                        descriptionElement != null) {
                                      var src = imgElement.attributes['src'];

                                      descriptionElement
                                          .querySelectorAll('span')
                                          .forEach((span) {
                                        span.remove();
                                      });

                                      var caption = descriptionElement.text
                                          .replaceAll("•", "")
                                          .stripHtml();
                                      var credits = descriptionElement
                                              .querySelector('.gallery__credit')
                                              ?.text ??
                                          '';

                                      htmlImages.add(Images(
                                          url: src,
                                          caption: caption,
                                          credits: credits,
                                          alt: caption,
                                          id: htmlImages.length + 1));
                                    }
                                  }

                                  return StatefulBuilder(
                                      builder: (context, setStateLocal) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onHorizontalDragEnd: (details) {
                                            double dragEndPosition = details
                                                .velocity.pixelsPerSecond.dx;

                                            if (dragEndPosition > 0) {
                                              setState(() {
                                                if (currentEmbedIndex > 0) {
                                                  currentEmbedIndex--;
                                                  _scrollToEmbedIndex(
                                                      currentEmbedIndex);
                                                }
                                              });

                                              setStateLocal(() {});
                                            } else if (dragEndPosition < 0) {
                                              setState(() {
                                                if (currentEmbedIndex <
                                                    htmlImages.length - 1) {
                                                  currentEmbedIndex++;
                                                  _scrollToEmbedIndex(
                                                      currentEmbedIndex);
                                                }
                                              });

                                              setStateLocal(() {});
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.black),
                                                child: Image.network(
                                                  htmlImages[currentEmbedIndex]
                                                      .url!,
                                                  height: 300,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Positioned(
                                                  top: 16,
                                                  left: 16,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Text(
                                                      "${currentEmbedIndex + 1} de ${htmlImages.length}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            'CNN Sans Display',
                                                        fontFamilyFallback: [
                                                          'HelveticaNeue',
                                                          'Helvetica',
                                                          'Arial',
                                                          'Utkal',
                                                          'sans-serif'
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              Positioned(
                                                  top: 16,
                                                  right: 16,
                                                  child: GestureDetector(
                                                    onTap: () =>
                                                        _showEmbedGalleryModal(
                                                            context,
                                                            setStateLocal),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                      child: SvgPicture.network(
                                                        'https://www.cnnbrasil.com.br/wp-content/plugins/shortcode-gallery/assets/img/ico-full.svg',
                                                        placeholderBuilder:
                                                            (context) =>
                                                                const CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                  )),
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  height: 192,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 24,
                                                          bottom: 16),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(1),
                                                        Colors.black
                                                            .withOpacity(0),
                                                      ],
                                                      stops: const [0.38, 0.59],
                                                    ),
                                                  ),
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: SizedBox(
                                                    height: 64,
                                                    child: Scrollbar(
                                                      controller:
                                                          ScrollController(),
                                                      thumbVisibility: true,
                                                      trackVisibility: true,
                                                      thickness: 6,
                                                      radius:
                                                          const Radius.circular(
                                                              8),
                                                      scrollbarOrientation:
                                                          ScrollbarOrientation
                                                              .right,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 16,
                                                                  top: 2),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: htmlImages[
                                                                              currentEmbedIndex]
                                                                          .caption
                                                                          ?.stripHtml() ??
                                                                      '',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        'CNN Sans Display',
                                                                    fontFamilyFallback: [
                                                                      'HelveticaNeue',
                                                                      'Helvetica',
                                                                      'Arial',
                                                                      'Utkal',
                                                                      'sans-serif'
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (htmlImages[currentEmbedIndex]
                                                                            .credits !=
                                                                        null &&
                                                                    htmlImages[
                                                                            currentEmbedIndex]
                                                                        .credits!
                                                                        .isNotEmpty) ...[
                                                                  const TextSpan(
                                                                    text: ' • ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontFamily:
                                                                          'CNN Sans Display',
                                                                      fontFamilyFallback: [
                                                                        'HelveticaNeue',
                                                                        'Helvetica',
                                                                        'Arial',
                                                                        'Utkal',
                                                                        'sans-serif'
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: htmlImages[
                                                                            currentEmbedIndex]
                                                                        .credits!,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          'CNN Sans Display',
                                                                      fontFamilyFallback: [
                                                                        'HelveticaNeue',
                                                                        'Helvetica',
                                                                        'Arial',
                                                                        'Utkal',
                                                                        'sans-serif'
                                                                      ],
                                                                    ),
                                                                  )
                                                                ]
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        SizedBox(
                                          height: 85,
                                          child: SingleChildScrollView(
                                            controller: _embedScrollController,
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                for (int index = 0;
                                                    index < htmlImages.length;
                                                    index++)
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        currentEmbedIndex =
                                                            index;
                                                        _scrollToEmbedIndex(
                                                            index);
                                                      });

                                                      setStateLocal(() {});
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 1.5),
                                                      child: Stack(
                                                        children: [
                                                          Image.network(
                                                            htmlImages[index]
                                                                .url!,
                                                            width: 150,
                                                            height: 85,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            left: 0,
                                                            right: 0,
                                                            child: Container(
                                                              height: 7,
                                                              color: index ==
                                                                      currentEmbedIndex
                                                                  ? Theme.of(
                                                                          context)
                                                                      .primaryColor
                                                                  : Colors
                                                                      .transparent,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            if (article.tags != null &&
                                article.tags!.isNotEmpty) ...[
                              Text(
                                'Tópicos',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'CNN Sans Display',
                                  fontFamilyFallback: const [
                                    'HelveticaNeue',
                                    'Helvetica',
                                    'Arial',
                                    'Utkal',
                                    'sans-serif'
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (ArticleTags tag in article.tags
                                        ?.where((t) => t.hidden == false) ??
                                    [])
                                  InkWell(
                                    onTap: tag.permalink != null
                                        ? () {
                                            var url = tag.permalink!;

                                            if (!url.contains(
                                                'https://www.cnnbrasil.com.br')) {
                                              url =
                                                  "https://www.cnnbrasil.com.br$url?hidemenu=true";
                                            }

                                            if (!url.contains("hidemenu")) {
                                              url = "$url?hidemenu=true";
                                            }

                                            NavigatorManager(context).to(
                                                CustomWebView.route,
                                                data: WebviewNavigatorModel(
                                                    url: url, title: 'Voltar'),
                                                onFinished: () {},
                                                analytics:
                                                    NavigatorAnalytics.fromUrl(
                                                  tag.permalink!,
                                                ));
                                          }
                                        : null,
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxHeight: 34,
                                        minHeight: 34,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0XFFD0D0D0)),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Text(
                                              tag.name ?? "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'CNN Sans Display',
                                                fontFamilyFallback: const [
                                                  'HelveticaNeue',
                                                  'Helvetica',
                                                  'Arial',
                                                  'Utkal',
                                                  'sans-serif'
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            if (articlesMostRead.posts.isNotEmpty &&
                                articleType != 'forum') ...[
                              const SizedBox(height: 24),
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    article.category?.hierarchy?.isNotEmpty ==
                                            true
                                        ? 'Mais Lidas de ${article.category!.hierarchy!.first[0].toUpperCase()}${article.category!.hierarchy!.first.substring(1)}'
                                        : 'Mais Lidas',
                                    style: TextStyle(
                                      fontSize: 18,
                                      height: 32 / 18,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'CNN Sans Display',
                                      fontFamilyFallback: const [
                                        'HelveticaNeue',
                                        'Helvetica',
                                        'Arial',
                                        'Utkal',
                                        'sans-serif'
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Transform.translate(
                                    offset: const Offset(0, 1.5),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      NavigatorManager(context).to(
                                        Article.route,
                                        data: ArticleSettings(
                                            articleId: articlesMostRead
                                                .posts.first.slug!,
                                            articleUrl: ""),
                                        onFinished: () {},
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            if (articlesMostRead.posts.first
                                                    .featuredMedia !=
                                                null)
                                              Image.network(
                                                articlesMostRead.posts.first
                                                    .featuredMedia!.image.url,
                                              ),
                                            Container(
                                              width: 19,
                                              height: 19,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '1',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.fontFamily,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          articlesMostRead.posts.first.title ??
                                              '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                  ),
                                  for (int index = 0;
                                      index <
                                          articlesMostRead.posts
                                              .skip(1)
                                              .take(4)
                                              .length;
                                      index++) ...[
                                    const SizedBox(height: 1),
                                    if (index > 0)
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiaryContainer,
                                      ),
                                    const SizedBox(height: 1),
                                    InkWell(
                                      onTap: () {
                                        NavigatorManager(context).to(
                                          Article.route,
                                          data: ArticleSettings(
                                              articleId: articlesMostRead
                                                  .posts[index + 1].slug!,
                                              articleUrl: ""),
                                          onFinished: () {},
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              if (articlesMostRead
                                                      .posts[index + 1]
                                                      .featuredMedia !=
                                                  null)
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  width: 152,
                                                  height: 134,
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Image.network(
                                                    articlesMostRead
                                                        .posts[index + 1]
                                                        .featuredMedia!
                                                        .image
                                                        .url,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              Container(
                                                width: 19,
                                                height: 19,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${index + 2}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium
                                                              ?.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              articlesMostRead
                                                      .posts[index + 1].title ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.fontFamily,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                  ]
                                ],
                              ),
                              const SizedBox(height: 35),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                              const SizedBox(height: 35),
                            ],
                            if (articlePartners.posts.isNotEmpty) ...[
                              const SizedBox(height: 40),
                              Text(
                                'Conteúdo de parceiros',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              for (var partner in articlePartners.posts) ...[
                                InkWell(
                                  onTap: () {
                                    _openInBrowser(partner.permalink);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(
                                        partner.title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.fontFamily,
                                        ),
                                      ),
                                      Text(
                                        'Por: ${partner.partnerName}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.underline,
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.fontFamily,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Divider(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiaryContainer,
                                      ),
                                    ],
                                  ),
                                )
                              ]
                            ],
                            const SizedBox(height: 10),
                            if (article.category?.slug != null &&
                                articleType != 'forum') ...[
                              FutureBuilder(
                                future: getWebStorie(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Webstories ${article.category!.hierarchy!.first[0].toUpperCase()}${article.category!.hierarchy!.first.substring(1)}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Transform.translate(
                                              offset: const Offset(0, 1.5),
                                              child: Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        for (var storie in snapshot.data!) ...[
                                          const SizedBox(height: 10),
                                          InkWell(
                                            onTap: () {
                                              NavigatorManager(context).modal(
                                                StorieDetail(
                                                  url:
                                                      '${storie.permalink}/?hidemenu=true',
                                                ),
                                                fullscreenDialog: true,
                                              );
                                            },
                                            child: SizedBox(
                                              height: 134,
                                              child: Row(
                                                children: [
                                                  if (storie.thumbnail != null)
                                                    Image.network(
                                                      storie.thumbnail!,
                                                      width: 152,
                                                      height: 134,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      storie.title ?? '',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiaryContainer,
                                          ),
                                        ]
                                      ],
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DynamicWebView extends StatefulWidget {
  final String visualisationUrl;
  final Function(double) onHeightUpdate;
  final double? webViewHeight;

  const DynamicWebView({
    super.key,
    required this.visualisationUrl,
    required this.onHeightUpdate,
    this.webViewHeight,
  });

  @override
  State<DynamicWebView> createState() => _DynamicWebViewState();
}

class _DynamicWebViewState extends State<DynamicWebView> {
  late InAppWebViewController _webViewController;

  double get _webViewHeight => widget.webViewHeight ?? 600;

  double newDynamicHeight = 600;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.visualisationUrl)),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        thirdPartyCookiesEnabled: true,
        cacheEnabled: true,
        transparentBackground: true,
      ),
      onWebViewCreated: (controller) async {
        _webViewController = controller;
        final cookieManager = CookieManager.instance();
    
        await cookieManager.setCookie(
          url: WebUri(widget.visualisationUrl),
          name: "OptanonAlertBoxClosed",
          value: "2025-02-26T08:47:35.404Z",
          domain: "public.flourish.studio",
        );
    
        await cookieManager.setCookie(
          url: WebUri(widget.visualisationUrl),
          name: "OptanonConsent",
          value:
              "isGpcEnabled=0&datestamp=Wed+Feb+26+2025+05%3A47%3A35+GMT-0300+(Brasilia+Standard+Time)&version=202301.2.0&isIABGlobal=false&hosts=&landingPath=NotLandingPage&groups=C0001%3A1%2CC0002%3A1%2CC0003%3A1%2CC0004%3A1&AwaitingReconsent=false",
          domain: ".flourish.studio",
        );
    
        _webViewController.reload();
      },
      onLoadStop: (controller, url) async {
        await Future.delayed(const Duration(milliseconds: 1000));

        final heightStr = await controller.evaluateJavascript(
            source: "document.documentElement.scrollHeight.toString();");
    
        if (heightStr != null) {
          double newHeight = double.tryParse(heightStr) ?? _webViewHeight;

          newHeight = newHeight - 891;

          if (newHeight != _webViewHeight) {
            widget.onHeightUpdate(newHeight);
          }
        }
      },
    );
  }
}

class DynamicTwitterWebView extends StatefulWidget {
  final String visualisationUrl;
  final Function(double) onHeightUpdate;
  final double? webViewHeight;

  const DynamicTwitterWebView({
    super.key,
    required this.visualisationUrl,
    required this.onHeightUpdate,
    this.webViewHeight,
  });

  @override
  State<DynamicTwitterWebView> createState() => _DynamicTwitterWebViewState();
}

class _DynamicTwitterWebViewState extends State<DynamicTwitterWebView> {
  double get _webViewHeight => widget.webViewHeight ?? 100;

  double newDynamicHeight = 100;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(
        data: widget.visualisationUrl
      ),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          mediaPlaybackRequiresUserGesture: false,
          userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
          supportZoom: true
        ),
      ),
      onLoadStop: (controller, url) async {
        await Future.delayed(const Duration(milliseconds: 1500));

        final heightStr = await controller.evaluateJavascript(
            source: "document.documentElement.scrollHeight.toString();");
    
        if (heightStr != null) {
          double newHeight = double.tryParse(heightStr) ?? _webViewHeight;
          if (newHeight != _webViewHeight) {
            widget.onHeightUpdate(newHeight);
          }
        }
      },
    );
  }
}

Widget _buildSocialIcon(String? url, String iconUrl) {
  void openInBrowser(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Ocorreu um erro ao abrir a URL: $url';
    }
  }

  return InkWell(
    onTap: () {
      if (url != null && url.isNotEmpty) {
        openInBrowser(url);
      }
    },
    child: Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: SvgPicture.network(
        iconUrl,
        fit: BoxFit.contain,
      ),
    ),
  );
}

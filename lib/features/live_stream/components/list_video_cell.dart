import 'package:cnn_brasil_app/core/models/wrapper_live_strem_model.dart';
import 'package:flutter/material.dart';

import '../../../core/index.dart';

class ListVideoCell extends StatelessWidget {
  final WrapperLiveStreamModel model;
  final Color backgroundColor;
  final Function(LiveStreamModel model)? onSelectedVideo;

  const ListVideoCell({
    super.key,
    required this.model,
    required this.backgroundColor,
    this.onSelectedVideo,
  });

  @override
  Widget build(BuildContext context) {
    return model.items.isEmpty
        ? const SizedBox.shrink()
        : Container(
            color: backgroundColor,
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.KPADDING_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: CustomText(
                    model.title,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final video = model.items[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () => onSelectedVideo?.call(video),
                          child: Container(
                            height: 180,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: FadeInImage(
                              placeholderFit: BoxFit.scaleDown,
                              placeholder: const AssetImage(
                                'assets/images/logo_splash_wihite.png',
                              ),
                              image: NetworkImage(video.thumbnail?.max ??
                                  'https://img.youtube.com/vi/1ZRS-JiOiVo/maxresdefault.jpg'),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/logo_splash_wihite.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                );
                              },
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.KPADDING_16),
                          child: CustomText(
                            video.title ?? '',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 45),
                ),
              ],
            ),
          );
  }
}

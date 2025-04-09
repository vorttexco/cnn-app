import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/models/wrapper_live_strem_model.dart';
import 'list_video_cell.dart';

class CustomPageView extends StatelessWidget {
  final LiveOnModel? liveOnModel;
  final WrapperLiveStreamModel menu0;
  final WrapperLiveStreamModel menu1;
  final WrapperLiveStreamModel menu2;
  final WrapperLiveStreamModel menu3;
  final WrapperLiveStreamModel menu4;
  final WrapperLiveStreamModel menu5;
  final WrapperLiveStreamModel menu6;
  final WrapperLiveStreamModel menu7;
  final WrapperLiveStreamModel menu8;
  final WrapperLiveStreamModel menu9;
  final WrapperLiveStreamModel menu10;
  final WrapperLiveStreamModel menu11;
  final WrapperLiveStreamModel menu12;
  final Function(LiveStreamModel model)? onSelectedVideo;

  final bool showPlayer;

  final WebViewController? webViewController;


  const CustomPageView({
    super.key,
    required this.menu0,
    required this.menu1,
    required this.menu2,
    required this.menu3,
    required this.menu4,
    required this.menu5,
    required this.menu6,
    required this.menu7,
    required this.menu8,
    required this.menu9,
    required this.menu10,
    required this.menu11,
    required this.menu12,
    this.showPlayer = false,
    this.liveOnModel,
    this.onSelectedVideo,
    this.webViewController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: showPlayer && liveOnModel != null,
            child: CustomVideoPlayer(
              model: liveOnModel,
              url: '${ApiHome.home}/youtube/video/?youtube_id=${liveOnModel?.live?.video?.id}&youtube_adformat=aovivo&hidemenu=true&youtube_mode=teatro'
            ),
          ),
          ListVideoCell(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            model: menu0,
            onSelectedVideo: onSelectedVideo,
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu1,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu2,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu3,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu4,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu5,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu6,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu7,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu8,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu9,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu10,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu11,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
          SingleChildScrollView(
            child: ListVideoCell(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              model: menu12,
              onSelectedVideo: onSelectedVideo,
            ),
          ),
        ],
      ),
    );
  }
}

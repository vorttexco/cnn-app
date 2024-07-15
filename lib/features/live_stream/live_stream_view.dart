import 'package:cnn_brasil_app/core/models/wrapper_live_strem_model.dart';
import 'package:cnn_brasil_app/features/live_stream/components/custom_page_view.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import './live_stream_view_model.dart';
import 'components/menu_horizontal.dart';

class LiveStreamView extends LiveStreamViewModel {
  @override
  Widget build(BuildContext context) {
    return _createBody();
  }

  Scaffold _createBody() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          AppBarInternal(
            onFinished: () {
              setState(() {});
            },
            backgroundColor: Colors.black,
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            onIconPressed: openMenu,
            titleWidget: const CustomText(
              'CNN Vídeos',
              fontSize: AppConstants.KFONTSIZE_18,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            avatar: AppManager.user != null
                ? Image.network(AppManager.user?.picture ?? '')
                : null,
          ),
          // Menu
          Container(
            color: const Color(0xFF282828),
            child: Column(
              children: [
                const SizedBox(height: 18),
                LiveMenuHorizontal(
                  items: listOfMenu,
                  onSelectedMenu: onSelectedMenu,
                  selectedIndex: indexMenuSelected,
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
          Expanded(
            child: _createPageViews(),
          )
        ],
      ),
    );
  }

  PageView _createPageViews() {
    return PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Page 0
        CustomPageView(
          showPlayer: true,
          onSelectedVideo: onSelectVideo,
          webViewController: liveOnController,
          menu0: WrapperLiveStreamModel.toView(menu0),
          menu1: WrapperLiveStreamModel.toView(menu1),
          menu2: WrapperLiveStreamModel.toView(menu2),
          menu3: WrapperLiveStreamModel.toView(menu3),
          menu4: WrapperLiveStreamModel.toView(menu4),
          menu5: WrapperLiveStreamModel.toView(menu5),
          menu6: WrapperLiveStreamModel.toView(menu6),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
          liveOnModel: liveOnModel,
        ),
        // Page 1
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu0,
          menu1: WrapperLiveStreamModel.toView(menu1),
          menu2: WrapperLiveStreamModel.toView(menu2),
          menu3: WrapperLiveStreamModel.toView(menu3),
          menu4: WrapperLiveStreamModel.toView(menu4),
          menu5: WrapperLiveStreamModel.toView(menu5),
          menu6: WrapperLiveStreamModel.toView(menu6),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 2
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu1,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu2),
          menu3: WrapperLiveStreamModel.toView(menu3),
          menu4: WrapperLiveStreamModel.toView(menu4),
          menu5: WrapperLiveStreamModel.toView(menu5),
          menu6: WrapperLiveStreamModel.toView(menu6),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 2
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu2,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu3),
          menu4: WrapperLiveStreamModel.toView(menu4),
          menu5: WrapperLiveStreamModel.toView(menu5),
          menu6: WrapperLiveStreamModel.toView(menu6),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 3
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu3,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu4),
          menu5: WrapperLiveStreamModel.toView(menu5),
          menu6: WrapperLiveStreamModel.toView(menu6),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 4
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu4,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu5),
          menu6: WrapperLiveStreamModel.toView(menu6),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 5
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu5,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu6),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 6
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu6,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu5),
          menu7: WrapperLiveStreamModel.toView(menu7),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 7
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu7,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu5),
          menu7: WrapperLiveStreamModel.toView(menu6),
          menu8: WrapperLiveStreamModel.toView(menu8),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 8
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu8,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu5),
          menu7: WrapperLiveStreamModel.toView(menu6),
          menu8: WrapperLiveStreamModel.toView(menu7),
          menu9: WrapperLiveStreamModel.toView(menu9),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 9
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu9,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu5),
          menu7: WrapperLiveStreamModel.toView(menu6),
          menu8: WrapperLiveStreamModel.toView(menu7),
          menu9: WrapperLiveStreamModel.toView(menu8),
          menu10: WrapperLiveStreamModel.toView(menu10),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 10
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu10,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu5),
          menu7: WrapperLiveStreamModel.toView(menu6),
          menu8: WrapperLiveStreamModel.toView(menu7),
          menu9: WrapperLiveStreamModel.toView(menu8),
          menu10: WrapperLiveStreamModel.toView(menu9),
          menu11: WrapperLiveStreamModel.toView(menu11),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 11
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu11,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu5),
          menu7: WrapperLiveStreamModel.toView(menu6),
          menu8: WrapperLiveStreamModel.toView(menu7),
          menu9: WrapperLiveStreamModel.toView(menu8),
          menu10: WrapperLiveStreamModel.toView(menu9),
          menu11: WrapperLiveStreamModel.toView(menu10),
          menu12: WrapperLiveStreamModel.toView(menu12),
        ),
        // Page 12
        CustomPageView(
          onSelectedVideo: onSelectVideo,
          menu0: menu12,
          menu1: WrapperLiveStreamModel.toView(menu0),
          menu2: WrapperLiveStreamModel.toView(menu1),
          menu3: WrapperLiveStreamModel.toView(menu2),
          menu4: WrapperLiveStreamModel.toView(menu3),
          menu5: WrapperLiveStreamModel.toView(menu4),
          menu6: WrapperLiveStreamModel.toView(menu5),
          menu7: WrapperLiveStreamModel.toView(menu6),
          menu8: WrapperLiveStreamModel.toView(menu7),
          menu9: WrapperLiveStreamModel.toView(menu8),
          menu10: WrapperLiveStreamModel.toView(menu9),
          menu11: WrapperLiveStreamModel.toView(menu10),
          menu12: WrapperLiveStreamModel.toView(menu11),
        )
      ],
    );
  }
}

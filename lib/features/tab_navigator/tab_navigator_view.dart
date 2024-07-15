import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './tab_navigator_view_model.dart';

class TabNavigatorView extends TabNavigatorViewModel {
  @override
  Widget build(BuildContext context) {
    return Consumer<FullscreenProvider>(
      builder: (context, fullscreenProvider, child) {
        return Scaffold(
          bottomNavigationBar: fullscreenProvider.isFullScreen
              ? null
              : BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex:
                      Provider.of<TabbarProvider>(context).indexSelected,
                  backgroundColor: AppColor.primaryColor,
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.white,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: const TextStyle(
                      fontFamily: 'CNN Sans Display',
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  unselectedLabelStyle: const TextStyle(
                      fontFamily: 'CNN Sans Display',
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  onTap: onTabTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/home_off.svg'),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/home_on.svg'),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/ao_vivo_off.svg'),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/ao_vivo_on.svg'),
                      ),
                      label: 'CNN Vídeos',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/blog_off.svg'),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/blog_on.svg'),
                      ),
                      label: 'Blogs',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/storie_off.svg'),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/storie_on.svg'),
                      ),
                      label: 'Stories',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/search_off.svg'),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset('assets/icons/search_on.svg'),
                      ),
                      label: 'Busca',
                    ),
                  ],
                ),
          body: pages[Provider.of<TabbarProvider>(context).indexSelected],
        );
      },
    );
  }
}

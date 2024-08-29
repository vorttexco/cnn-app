import 'package:flutter/material.dart';

import '../../core/index.dart';
import './stories_view_model.dart';
import 'components/storie_menu_horizontal.dart';

class StoriesView extends StoriesViewModel {
  @override
  Widget build(BuildContext context) {
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
                'Stories',
                fontSize: AppConstants.KFONTSIZE_18,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
                textAlign: TextAlign.center,
              ),
              avatar: AppManager.user != null
                  ? Image.network(AppManager.user?.picture ?? '')
                  : null,
            ),
            StorieMenuHorizontal(
              items: listOfStories,
              backgroundColor: const Color(0xFF222222),
              textColor: Colors.white,
              showBottomLine: false,
              onSelectedMenu: onSelectedMenu,
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                controller: scrollControler,
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: storieViewSelected?.stories.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final storie = storieViewSelected?.stories[index];
                  return InkWell(
                    onTap: () => openLink(storie),
                    enableFeedback: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .62,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.network(
                                storie?.thumbnail ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: storie?.category?.color ?? const Color(0xFF3F4952),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: CustomText(
                                      storie?.category?.name ?? '',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: AppConstants.KPADDING_8),
                                  CustomText(
                                    storie?.title ?? '',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    fontHeight: 1.3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ));
  }
}

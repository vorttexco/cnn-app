import '../managers/navigator_manager.dart';
import '../../features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_constants.dart';
import 'custom_text.dart';

class AppBarInternal extends StatelessWidget {
  final String? title;
  final Widget? avatar;
  final Widget? titleWidget;
  final Widget? icon;
  final VoidCallback onIconPressed;
  final TextAlign textAlign;
  final Color backgroundColor;
  final VoidCallback? onFinished;
  final Color iconColor;

  const AppBarInternal({
    super.key,
    required this.onIconPressed,
    this.title,
    this.avatar,
    this.icon,
    this.textAlign = TextAlign.start,
    this.titleWidget,
    this.backgroundColor = Colors.white,
    this.onFinished,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: backgroundColor,
      padding: const EdgeInsets.only(
        left: AppConstants.KPADDING_16,
        right: AppConstants.KPADDING_16,
        top: AppConstants.KPADDING_16 * 2.5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _createBackbutton(),
          Expanded(
            child: SizedBox(
              child: titleWidget ??
                  CustomText(
                    title ?? '',
                    textAlign: textAlign,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black,
                    fontSize: AppConstants.KFONTSIZE_18,
                  ),
            ),
          ),
          _createProfileIcon(context)
        ],
      ),
    );
  }

  Widget _createBackbutton() {
    return InkWell(
      onTap: onIconPressed,
      child: Container(
        padding: const EdgeInsets.only(
            top: 5, right: AppConstants.KPADDING_16, bottom: 5),
        child: icon ??
            SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              height: 20,
            ),
      ),
    );
  }

  InkWell _createProfileIcon(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () {
        NavigatorManager(context).modal(
          const Profile(),
          fullscreenDialog: true,
          onFinished: onFinished,
        );
      },
      child: Container(
        width: 25,
        height: 25,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: avatar ??
            SvgPicture.asset(
              'assets/icons/settings_icon.svg',
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
      ),
    );
  }
}

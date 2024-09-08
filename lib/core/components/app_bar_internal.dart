import 'package:cnn_brasil_app/core/managers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/profile/profile.dart';
import '../app/app_constants.dart';
import '../managers/navigator_manager.dart';
import 'custom_text.dart';

class AppBarInternal extends StatelessWidget {
  final String? title;
  final Widget? avatar;
  final Widget? titleWidget;
  final Widget? icon;
  final VoidCallback onIconPressed;
  final TextAlign textAlign;
  final Color? backgroundColor;
  final VoidCallback? onFinished;
  final VoidCallback? onThemeUpdated;
  final Color? iconColor;

  const AppBarInternal({
    super.key,
    required this.onIconPressed,
    this.title,
    this.avatar,
    this.icon,
    this.textAlign = TextAlign.start,
    this.titleWidget,
    this.backgroundColor,
    this.onFinished,
    this.iconColor,
    this.onThemeUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(
        left: AppConstants.KPADDING_16,
        right: AppConstants.KPADDING_16,
        top: AppConstants.KPADDING_16 * 2.5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _createBackbutton(context),
          Expanded(
            child: SizedBox(
              child: titleWidget ?? _createBackTitle(),
            ),
          ),
          _createProfileIcon(context)
        ],
      ),
    );
  }

  Widget _createBackTitle() {
    return InkWell(
      onTap: onIconPressed,
      child: CustomText(
        title ?? '',
        textAlign: textAlign,
        fontWeight: FontWeight.w700,
        fontSize: AppConstants.KFONTSIZE_18,
      ),
    );
  }

  Widget _createBackbutton(BuildContext context) {
    return InkWell(
      onTap: onIconPressed,
      child: Container(
        padding: const EdgeInsets.only(
          top: 5,
          right: AppConstants.KPADDING_16,
          bottom: 5,
        ),
        child: icon ??
            SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              height: 20,
              colorFilter: ColorFilter.mode(
                iconColor ?? Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
      ),
    );
  }

  _compareThemes(String? oldTheme) async {
    if (onThemeUpdated == null) return;

    String? newTheme = await StorageManager()
        .getString(AppConstants.SHARED_PREFERENCES_THEME_MODE);

    if (oldTheme != newTheme && onThemeUpdated != null) {
      onThemeUpdated!();
    }
  }

  InkWell _createProfileIcon(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () async {
        String? theme = await StorageManager()
            .getString(AppConstants.SHARED_PREFERENCES_THEME_MODE);
        NavigatorManager(context).modal(
          Profile(
            onClose: () => _compareThemes(theme),
          ),
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
              colorFilter: ColorFilter.mode(
                iconColor ?? Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
      ),
    );
  }
}

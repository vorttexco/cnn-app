import 'package:cnn_brasil_app/core/models/navigator_analytics.dart';
import 'package:cnn_brasil_app/features/index.dart';
import 'package:cnn_brasil_app/features/notifications_settings/notifications_settings.dart';
import 'package:flutter/material.dart';

import '../../core/index.dart';
import './profile_view_model.dart';

class ProfileView extends ProfileViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLabel.profile,
          fontSize: AppConstants.KFONTSIZE_18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () {
              NavigatorManager(context).to(NotificationsSettings.route);
            },
            title: const CustomText(
              'Notificações',
              fontWeight: FontWeight.w400,
            ),
            subtitle: const CustomText(
                'Configure o recebimento de notificações',
                fontSize: 12),
            trailing: SvgPicture.asset('assets/icons/arrow_forward.svg'),
          ),
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            thickness: 1,
          ),
          // ListTile(
          //   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          //   onTap: () {
          //     openPage(Themes.route);
          //   },
          //   title: const CustomText(
          //     'Aparência',
          //     fontWeight: FontWeight.w400,
          //   ),
          //   subtitle: const CustomText(
          //       'Configure o modo claro ou escuro do app',
          //       fontSize: 12),
          //   trailing: SvgPicture.asset(
          //     'assets/icons/arrow_forward.svg',
          //     colorFilter: ColorFilter.mode(
          //       Theme.of(context).colorScheme.primary,
          //       BlendMode.srcIn,
          //     ),
          //   ),
          // ),
          // Divider(
          //   indent: AppConstants.KPADDING_DEFAULT,
          //   endIndent: AppConstants.KPADDING_DEFAULT,
          //   color: Theme.of(context).colorScheme.primaryContainer,
          //   thickness: 1,
          // ),
          const SizedBox(height: 8),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: listOfMenu.length,
            itemBuilder: (BuildContext context, int index) {
              final menu = listOfMenu[index];
              return SizedBox(
                height: 50,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  onTap: () => openLink(menu),
                  dense: true,
                  title:
                      CustomText(menu.title ?? '', fontWeight: FontWeight.w400),
                  trailing: SvgPicture.asset(
                    'assets/icons/arrow_forward.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              indent: AppConstants.KPADDING_DEFAULT,
              endIndent: AppConstants.KPADDING_DEFAULT,
              color: Theme.of(context).colorScheme.primaryContainer,
              thickness: 1,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Color(0xFFD6D6D6),
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 49),
        ],
      ),
    );
  }
}

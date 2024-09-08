import 'package:cnn_brasil_app/features/index.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
              OneSignal.InAppMessages.addTrigger('open-config', 'true');
            },
            title: const CustomText(
              'Notificações',
              fontWeight: FontWeight.w400,
            ),
            subtitle: const CustomText(
                'Configure o recebimento de notificações',
                fontSize: 12),
            trailing: SvgPicture.asset(
              'assets/icons/arrow_forward.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            height: 1,
            thickness: 1,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () {
              openPage(Themes.route);
            },
            title: const CustomText(
              'Aparência',
              fontWeight: FontWeight.w400,
            ),
            subtitle: const CustomText(
                'Configure o modo claro ou escuro do app',
                fontSize: 12),
            trailing: SvgPicture.asset(
              'assets/icons/arrow_forward.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Theme.of(context).colorScheme.primaryContainer,
            height: 1,
            thickness: 2,
          ),
          const SizedBox(height: 10),
          // const Spacer(),
          ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: listOfMenu.length,
            itemBuilder: (BuildContext context, int index) {
              final menu = listOfMenu[index];
              return SizedBox(
                height: 50,
                child: ListTile(
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
          const SizedBox(height: 49),
        ],
      ),
    );
  }
}

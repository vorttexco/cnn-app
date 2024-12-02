import 'package:cnn_brasil_app/features/index.dart';
import 'package:cnn_brasil_app/features/login/login.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              indent: AppConstants.KPADDING_DEFAULT,
              endIndent: AppConstants.KPADDING_DEFAULT,
              color: Theme.of(context).colorScheme.primaryContainer,
              thickness: 1,
            ),
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 84,
                    width: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: ClipOval(
                      child: Container(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                        padding: const EdgeInsets.only(top: 10),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => NavigatorManager(context).to(Login.route),
                    child: Text(
                      'Faça login em sua conta CNN',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () => NavigatorManager(context).to(Login.route),
                    child: Text(
                      'Não tem uma conta? Cadastre-se',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            Divider(
              indent: AppConstants.KPADDING_DEFAULT,
              endIndent: AppConstants.KPADDING_DEFAULT,
              color: Theme.of(context).colorScheme.primaryContainer,
              thickness: 1,
            ),
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
                    title: CustomText(menu.title ?? '',
                        fontWeight: FontWeight.w400),
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
      ),
    );
  }
}

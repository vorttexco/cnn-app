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
            const Divider(
              indent: AppConstants.KPADDING_DEFAULT,
              endIndent: AppConstants.KPADDING_DEFAULT,
              color: Color(0xFFD6D6D6),
              thickness: 1,
            ),
            InkWell(
              onTap: AppManager.user == null ? login : null,
              child: SizedBox(
                height: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      width: 84,
                      height: 84,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: AppManager.user != null
                          ? Image.network(AppManager.user?.picture ?? '')
                          : Image.asset('assets/images/logo_google.png'),
                    ),
                    const SizedBox(height: AppConstants.KPADDING_8),
                    CustomText(
                      AppManager.user?.name ?? 'acesse sua conta',
                      fontSize: AppConstants.KFONTSIZE_18,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: AppConstants.KPADDING_8),
                    CustomText(AppManager.user?.email ?? 'ou cadastre-se'),
                    const Spacer(),
                    const Divider(
                      indent: AppConstants.KPADDING_DEFAULT,
                      endIndent: AppConstants.KPADDING_DEFAULT,
                      color: Color(0xFFD6D6D6),
                      thickness: 1,
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: const CustomText(
                    'Notificações',
                    fontSize: AppConstants.KFONTSIZE_18,
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: const CustomText(
                    'Configure o recebimento de notificações',
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: Switch(
                    activeTrackColor: AppColor.primaryColor,
                    value: hasPermission,
                    onChanged: onTapPermissionRequest,
                  ),
                ),
                const Divider(
                  indent: AppConstants.KPADDING_DEFAULT,
                  endIndent: AppConstants.KPADDING_DEFAULT,
                  color: Color(0xFFD6D6D6),
                  thickness: 1,
                )
              ],
            ),
            const SizedBox(height: 100),
            const Divider(
              indent: AppConstants.KPADDING_DEFAULT,
              endIndent: AppConstants.KPADDING_DEFAULT,
              color: Colors.black,
              thickness: 2,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: listOfMenu.length,
              itemBuilder: (BuildContext context, int index) {
                final menu = listOfMenu[index];
                return SizedBox(
                  height: 50,
                  child: ListTile(
                      onTap: () => openLink(menu),
                      dense: true,
                      title: CustomText(menu.title ?? '',
                          fontWeight: FontWeight.w400),
                      trailing:
                          SvgPicture.asset('assets/icons/arrow_forward.svg')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                indent: AppConstants.KPADDING_DEFAULT,
                endIndent: AppConstants.KPADDING_DEFAULT,
                color: Color(0xFFD6D6D6),
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

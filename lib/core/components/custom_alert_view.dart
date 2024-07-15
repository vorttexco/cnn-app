import '../app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_constants.dart';
import '../app/app_label.dart';
import 'custom_text.dart';
import 'custom_button.dart';

class CustomAlertView {
  final BuildContext context;

  CustomAlertView(this.context);

  void show(
    String message, {
    String? title,
    Function? onPressedOk,
    String? buttonTitle,
  }) {
    showDialog(
      context: context,
      // barrierColor: Colors.black.withOpacity(0.9),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            // constraints: const BoxConstraints(maxWidth: 350),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.KPADDING_8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.KPADDING_24),
                CustomText(
                  title ?? AppLabel.appName,
                  fontSize: AppConstants.KFONTSIZE_18,
                  textAlign: TextAlign.center,
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.KPADDING_24,
                      vertical: AppConstants.KPADDING_24),
                  child: CustomText(
                    message,
                    textAlign: TextAlign.center,
                    textColor: AppColor.textColorGrey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppConstants.KPADDING_24),
                  child: CustomButton(
                    title: buttonTitle ?? AppLabel.ok,
                    icon: Icons.warning_amber_outlined,
                    onPressed: () {
                      Navigator.pop(context);
                      if (onPressedOk != null) onPressedOk();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void confirm(
      {required String message,
      required Function onTapYes,
      required Function onTapNo}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.KPADDING_8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 30, top: 30),
                  child: CustomText(
                    message,
                    textAlign: TextAlign.center,
                    textColor: AppColor.primaryColor,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(AppConstants.KPADDING_8),
                      bottomRight: Radius.circular(AppConstants.KPADDING_8),
                    ),
                    color: AppColor.primaryColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildButtonNo(
                          context,
                          onTapNo,
                        ),
                      ),
                      _buildDivider(),
                      Expanded(child: _buildButtonYes(context, onTapYes)),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildDivider() {
    return Container(
      width: 1,
      color: Colors.white,
    );
  }

  Widget _buildButtonNo(BuildContext context, Function onTapNo) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        onTapNo();
      },
      child: CustomText(
        AppLabel.no,
        textAlign: TextAlign.center,
        textColor: Colors.white,
      ),
    );
  }

  Widget _buildButtonYes(BuildContext context, Function onTapYes) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        onTapYes();
      },
      child: CustomText(
        AppLabel.yes,
        textColor: Colors.white,
      ),
    );
  }

  void custom(
      {required String title, required String message, required String icon}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.KPADDING_8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: AppConstants.KPADDING_24 * 2,
                      right: AppConstants.KPADDING_24 * 1.5,
                      top: AppConstants.KPADDING_24),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomText(
                        title,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        icon,
                        height: 50,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.KPADDING_24 * 2,
                      vertical: AppConstants.KPADDING_24),
                  child: SingleChildScrollView(
                    child: CustomText(
                      message,
                      fontSize: 18,
                      textColor: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppConstants.KPADDING_24 * 2,
                    right: AppConstants.KPADDING_24 * 2,
                    bottom: AppConstants.KPADDING_24 * 2,
                  ),
                  child: CustomButton(
                    title: AppLabel.ok,
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

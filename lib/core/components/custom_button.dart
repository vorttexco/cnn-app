import '../app/app_colors.dart';
import 'package:flutter/material.dart';

import '../app/app_constants.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool enabled;
  final FontWeight fontWeight;
  final double? borderRadius;
  final TextAlign textAlign;
  final bool isEnabled;
  final bool enableFeedback;
  final Color textColor;
  final double fontSize;
  final double height;
  final double width;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height = 40,
    this.width = double.infinity,
    this.isEnabled = true,
    this.textColor = Colors.white,
    this.textAlign = TextAlign.start,
    this.fontSize = 16,
    this.enableFeedback = true,
    this.fontWeight = FontWeight.w600,
    this.borderRadius,
    this.enabled = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.KPADDING_DEFAULT * 1.5,
          vertical: AppConstants.KPADDING_DEFAULT,
        ),
      ),
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon ?? Icons.check),
      label: CustomText(
        title,
        textColor: textColor,
        textAlign: textAlign,
      ),
    );
  }
}

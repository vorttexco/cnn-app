import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextAlign textAlign;
  final Color? textColor;
  final FontWeight fontWeight;
  final int? maxLines;
  final double? fontHeight;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final TextOverflow? overflow;
  final bool? softWrap;
  final EdgeInsets? padding;
  final TextHeightBehavior? textHeightBehavior;
  final TextDecoration decoration;

  const CustomText(
    this.text, {
    this.fontSize = 14,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.fontWeight = FontWeight.normal,
    this.maxLines,
    this.fontHeight = 1,
    this.style,
    this.onPressed,
    this.overflow,
    this.softWrap,
    this.padding,
    this.textHeightBehavior,
    super.key,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          textHeightBehavior: textHeightBehavior,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          style: style ??
              TextStyle(
                fontFamily: 'CNN Sans Display',
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight,
                decoration: decoration,
                height: fontHeight,
              ),
        ),
      ),
    );
  }
}

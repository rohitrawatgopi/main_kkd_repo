import 'package:flutter/material.dart';
import 'package:paint_shop/core/constants/color_constant.dart';

class AppText extends StatelessWidget {
  final String title;
  final double fontSize;
  final double? letterSpacing;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final int? maxLine;
  final double? height;
  final double? textScaling;

  const AppText({
    super.key,
    required this.title,
    this.color,
    this.textScaling = 1.01,
    this.height,
    this.maxLine,
    this.letterSpacing,
    this.textAlign,
    this.textOverflow,
    this.textDecoration,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      textScaleFactor: textScaling,
      maxLines: maxLine,
      style: TextStyle(
        height: height,

        color: color,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontWeight: fontWeight,

        overflow: textOverflow,
        fontFamily: 'SF Pro',

        decoration: textDecoration,
        fontStyle: fontStyle,
      ),
    );
  }
}

class ReqAppText extends StatelessWidget {
  final String? title;
  final String? title2;
  final double? height1;
  final double? height2;
  final double? height3;
  final double? height4;
  final String? title3;
  final String? title4;
  final double? fontSize;
  final FontWeight fontWeight1;
  final FontWeight? fontWeight2;

  final FontWeight? fontWeight3;
  final FontWeight? fontWeight4;
  final double? fontSize2;
  final double? fontSize3;
  final double? fontSize4;

  final Color? color1;
  final Color? color2;

  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;

  const ReqAppText({
    super.key,
    required this.title,
    required this.title2,
    this.title3,
    this.title4,
    this.height1,
    this.height2,
    this.height3,
    this.fontSize = 14,
    this.fontSize2 = 14,
    this.fontSize3 = 14,
    this.fontSize4 = 14,
    this.fontWeight1 = FontWeight.w400,
    this.fontWeight2,
    this.fontWeight3,
    this.fontWeight4,
    this.height4,
    this.color1,
    this.color2,
    this.textAlign,
    this.textOverflow,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        text: title,
        style: TextStyle(
          color: color1 ?? AppColors.textColor,
          fontSize: fontSize,
          fontFamily: 'SF Pro Display',
          fontWeight: fontWeight1,
          height: height1,
          // ...
        ),

        children: [
          TextSpan(
            text: title2,
            style: TextStyle(
              fontSize: fontSize2,
              fontWeight: fontWeight2,
              color: color2 ?? AppColors.textLightColor,
              fontFamily: 'SF Pro Display',
            ),
          ),
          TextSpan(
            text: title3,
            style: TextStyle(
              height: height3,
              fontSize: fontSize3,
              fontWeight: fontWeight3,
              color: color2 ?? AppColors.textLightColor,
              fontFamily: 'SF Pro Display',
            ),
          ),
          TextSpan(
            text: title4,
            style: TextStyle(
              height: height4,
              fontSize: fontSize4,
              fontWeight: fontWeight2,
              color: color2 ?? AppColors.textLightColor,
              fontFamily: 'SF Pro Display',
            ),
          ),
        ],
      ),
    );
  }
}

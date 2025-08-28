// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:paint_shop/core/constants/color_constant.dart';
import 'package:paint_shop/l10n/app_localizations.dart';
import 'package:paint_shop/utils/app_text.dart';

class ProfileProgressContainer extends StatelessWidget {
  final int value;
  const ProfileProgressContainer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return value == 3
        ? Gap(1)
        : Container(
            width: 343.w,
            height: 120.h,

            padding: EdgeInsets.only(
              left: 8.w,
              top: 8.h,
              bottom: 8.h,
              right: 8.w,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.progresscardColor1,
                  AppColors.progresscardColor,
                ],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                AppText(
                  title: AppLocalizations.of(context)!.completeYourProfile,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,

                  height: 1.5,
                ),

                AppText(
                  title: AppLocalizations.of(context)!.thisHelpsBuildTrust,
                  fontSize: 12.sp,
                  height: 1.3,

                  fontWeight: FontWeight.w400,
                ),

                AppText(
                  title: "${value} " + AppLocalizations.of(context)!.outOf,
                  fontWeight: FontWeight.w600,

                  fontSize: 14.sp,
                  height: 1,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 99.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: value > 0
                            ? AppColors.progressColor
                            : AppColors.appWhite,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Container(
                      width: 99.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: value > 1
                            ? AppColors.progressColor
                            : AppColors.appWhite,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Container(
                      width: 99.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: value == 3
                            ? AppColors.progressColor
                            : AppColors.appWhite,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

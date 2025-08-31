import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/features/3bottom/home/widget/help.support.dart';
import 'package:paint_shop/features/3bottom/profile/widget/delete.account.dart';
import 'package:paint_shop/features/3bottom/profile/widget/setting.widget.dart';
import 'package:paint_shop/features/4lang/lang.cubit.dart';
import 'package:paint_shop/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  UserModel user = HomeCubit.reusableUser;

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LanguageCubit>().state.languageCode;
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: SizedBox(
                  height: 24.h,
                  width: 34.w,

                  child: SvgPicture.asset(
                    AppImage.backImg,

                    height: 15.h,
                    width: 18.w,
                  ),
                ),
              ),
              Gap(4.w),
              AppText(
                title: AppLocalizations.of(context)!.settings,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ],
          ),

          Gap(12.h),
          SettingWidget(
            title: AppLocalizations.of(context)!.username,
            subtitle: user.fullName,
          ),
          Gap(12.h),
          SettingWidget(
            title: AppLocalizations.of(context)!.email,
            subtitle: user.email,
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppImage.language,

                    height: 25.h.h,
                    width: 25.h.h,
                  ),
                  Gap(5.w),
                  AppText(
                    title: AppLocalizations.of(context)!.language,
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              DropdownButton<String>(
                value: currentLocale,
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'hi', child: Text('हिंदी')),
                ],
                onChanged: (String? lang) {
                  if (lang != null) {
                    context.read<LanguageCubit>().changeLanguage(lang);
                  }
                },
              ),
            ],
          ),
          Gap(4.w),

          InkWell(
            onTap: () => showHelpSupportDialog(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImage.helpImg,
                      height: 20.h,
                      width: 20.h,
                    ),
                    Gap(5.w),
                    AppText(
                      title: AppLocalizations.of(context)!.helpSupport,
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  AppImage.rightArrow,
                  height: 25.h.h,
                  width: 25.h.h,
                ),
              ],
            ),
          ),
          Gap(12.w),

          InkWell(
            onTap: () {
              launchUrl(Uri.parse(ApiEndpoints.termsPrivacy));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImage.file,
                      height: 25.h.h,
                      width: 25.h.h,
                    ),
                    Gap(5.w),
                    AppText(
                      title: AppLocalizations.of(context)!.privacypolicy,
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),

                SvgPicture.asset(
                  AppImage.rightArrow,
                  height: 25.h.h,
                  width: 25.h.h,
                ),
              ],
            ),
          ),
          Gap(12.w),

          InkWell(
            onTap: () => showLogoutDialog(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImage.singOut,
                      height: 25.h.h,
                      width: 25.h.h,
                    ),
                    Gap(5.w),
                    AppText(
                      title: AppLocalizations.of(context)!.logout,
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),

                SvgPicture.asset(
                  AppImage.rightArrow,
                  height: 25.h.h,
                  width: 25.h.h,
                ),
              ],
            ),
          ),
          Gap(12.w),
          InkWell(
            onTap: () => showDeleteAccount(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImage.delete,
                      height: 25.h.h,
                      width: 25.h.h,
                    ),
                    Gap(5.w),
                    AppText(
                      title: AppLocalizations.of(context)!.deleteaccount,
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),

                SvgPicture.asset(
                  AppImage.rightArrow,
                  height: 25.h.h,
                  width: 25.h.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class CustomKkdCard extends StatelessWidget {
  final UserModel user;

  const CustomKkdCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 183.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(AppImage.kkdCardImg),

          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title: AppLocalizations.of(context)!.welcomeBack,
                fontSize: 12.sp,
                height: 1,
                fontWeight: FontWeight.w500,
              ),
              AppText(
                title: AppLocalizations.of(context)!.kkdCard,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ],
          ),
          Gap(4.w),

          Row(
            children: [
              Image.asset(
                AppImage.dollar,
                height: 24.h,
                width: 24.w,
                fit: BoxFit.cover,
              ),
              Gap(5.w),
              AppText(
                title: user.coinsEarned.toString(),
                height: 1.1,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Gap(10.h),

          AppText(
            title: user.userId.toString(),
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            height: .8,
          ),
          Gap(8.h),
          AppText(
            title: user.fullName.toString(),
            fontSize: 14.sp,
            height: 1,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),

          Gap(12.h),

          InkWell(
            onTap: () {
              context.push("/trasnactionhistory");
            },
            child: AppText(
              title: AppLocalizations.of(context)!.viewDetails,
              fontSize: 12.sp,
              height: 1,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

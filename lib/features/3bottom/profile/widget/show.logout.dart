import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/services/token.hive.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: AppColors.appColor,
      title: Row(
        children: [
          Icon(Icons.logout, color: Colors.red),
          SizedBox(width: 8),
          AppText(
            title: AppLocalizations.of(context)!.logout,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      content: AppText(
        title: AppLocalizations.of(context)!.areyousureyouwanttologout,
      ),
      actionsPadding: EdgeInsets.only(bottom: 12, right: 12),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 130.w,
              height: 40.h,
              child: AppButton(
                radius: 12,
                title: AppLocalizations.of(context)!.logout,
                color: Colors.red,
                onPressed: () async {
                  await Hive.box('authBox').clear();
                  await Token.getToken();
                  Navigator.pop(context);

                  context.go('/splash');
                },
              ),
            ),
            SizedBox(width: 12.w),
            SizedBox(
              width: 100.w,
              height: 40.h,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(color: Colors.grey[700], fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

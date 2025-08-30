import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class CustomLoginHeaad extends StatelessWidget {
  const CustomLoginHeaad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.1.h,
      margin: EdgeInsets.only(left: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            fontWeight: FontWeight.w500,
            height: 1.2,
            title: AppLocalizations.of(context)!.welcomeBack,
            color: Colors.black,
            fontSize: 18.sp,
          ),

          AppText(
            fontWeight: FontWeight.w500,
            title: AppLocalizations.of(context)!.loginToContinue,
            height: 1.3,
            color: Colors.black,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}

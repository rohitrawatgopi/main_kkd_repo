import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class CustomSingupHead extends StatelessWidget {
  const CustomSingupHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, top: 72.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            fontWeight: FontWeight.w500,
            title: AppLocalizations.of(context)!.signUp,
            color: Colors.black,
            fontSize: 18.sp,

            height: 1.3.sp,
          ),

          AppText(
            fontWeight: FontWeight.w500,
            title: AppLocalizations.of(context)!.createYourAccount,
            color: Colors.black,
            fontSize: 14.sp,
            height: 1.3.sp,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

void showDeleteAccount(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: AppColors.appColor,
      title: Row(
        children: [
          Icon(Icons.delete_forever, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: AppText(
              title: AppLocalizations.of(context)!.deleteaccount,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              maxLine: 2,
            ),
          ),
        ],
      ),
      content: AppText(
        title: AppLocalizations.of(context)!.areyousuretodelteaccount,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),

      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state is DeletAccountFailState) {
                  AppToast.error(state.msg);
                }
                if (state is DeletAccountSuccessState) {
                  AppToast.success(state.msg);
                  await Hive.box('authBox').clear();

                  Navigator.pop(context);

                  context.go('/splash');
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: 130.w,
                  height: 40.h,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is DeletAccountLoadingState) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.purple,
                            size: 50.0,
                          ),
                        );
                      }

                      return AppButton(
                        radius: 12,
                        title: AppLocalizations.of(context)!.delete,
                        color: Colors.red,
                        onPressed: () {
                          context.read<AuthCubit>().accountDelete();
                        },
                      );
                    },
                  ),
                );
              },
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

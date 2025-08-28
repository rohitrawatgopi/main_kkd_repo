import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/4lang/lang.cubit.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        left: 0,
        right: 0,
        child: Column(
          children: [
            Gap(2),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Column(
                  children: [
                    AppText(
                      title: "Select Language",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    Gap(40.h),
                    AppButton(
                      radius: 6.r,
                      hight: 200.h,
                      width: 300.w,
                      onPressed: () {
                        context.read<LanguageCubit>().changeLanguage("en");
                        context.go("/login");
                      },
                      title: "English",
                      fontSize: 30.sp,

                      textColor: Colors.black,
                    ),
                    Gap(10.h),
                    AppButton(
                      color: AppColors.appColor,
                      radius: 6.r,
                      hight: 200.h,
                      width: 300.w,
                      onPressed: () async {
                        context.read<LanguageCubit>().changeLanguage("hi");
                        context.go("/login");
                      },
                      textColor: Colors.black,
                      title: "हिन्दी / Hindi",
                      fontSize: 30.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: 375.w,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
          color: AppColors.appWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(24.h),
            Center(
              child: AppText(
                textAlign: TextAlign.center,
                title: AppLocalizations.of(context)!.filter,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                height: 1.2,
              ),
            ),

            Divider(),

            AppText(
              title: AppLocalizations.of(context)!.category,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              height: 1.5,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(HomeCubit.resuableCategory.length, (
                index,
              ) {
                return InkWell(
                  onTap: () async {
                    ProductCategoryCubit.pageCategory = 1;
                    context.read<ProductCategoryCubit>().categoryVise(
                      HomeCubit.resuableCategory[index].id,
                    );
                    context.push(
                      "/cactegoryProduct",
                      extra: {
                        "category": HomeCubit.resuableCategory[index].id,
                        "screenName":
                            HomeCubit.resuableCategory[index].categoryName,
                      },
                    );
                  },
                  child: Container(
                    height: 32.w,
                    width: 105.w,
                    padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Center(
                      child: AppText(
                        fontSize: 14.sp,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w400,
                        title: HomeCubit.resuableCategory[index].categoryName,

                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
            Gap(20.h),
          ],
        ),
      );
    },
  );
}

import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class RewardDetailsScreen extends StatelessWidget {
  final ProductModel offerProduct;
  const RewardDetailsScreen({super.key, required this.offerProduct});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      left: 8.w,
      right: 8.w,
      top: 72.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(
                left: 8.w,
                right: 8.w,
                bottom: 8.h,
              ),
              child: Row(
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
                    title: AppLocalizations.of(context)!.productDetails,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ],
              ),
            ),
            Gap(8.h),
            SizedBox(
              height: 208.h,
              width: 370.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: CachedNetworkImage(
                  imageUrl:
                      offerProduct.productImage ??
                      "https://dummyimage.com/100x100",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
            Gap(12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: offerProduct.productName,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),

                  AppText(
                    title: offerProduct.description,
                    fontWeight: FontWeight.w400,
                  ),
                  Gap(10.h),
                  ReqAppText(
                    fontSize: 16.sp,
                    fontWeight1: FontWeight.w500,

                    title: AppLocalizations.of(context)!.purchasingPoints,
                    title2: offerProduct.coinReward.toString(),
                    color2: AppColors.priceGreen,
                  ),
                  Gap(102.h),
                  AppButton(
                    color: AppColors.buttonColor,
                    onPressed: () {},
                    title: AppLocalizations.of(context)!.redeem,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

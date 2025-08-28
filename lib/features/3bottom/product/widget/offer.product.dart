import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class OfferProductCard extends StatelessWidget {
  final ProductModel product;
  const OfferProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.push("/details", extra: product);
          },
          child: Container(
            height: 191.h,
            width: 164.w,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(3.r),
                  child: CachedNetworkImage(
                    cacheManager: MyCacheManager.instance,
                    imageUrl: product.productImage,
                    height: 123.h,

                    width: 148.w,
                    fit: BoxFit.cover,

                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(Icons.error)),
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: CircleAvatar(radius: 80.r),
                          ),
                        ),
                  ),
                ),
                Container(
                  height: 48.h,
                  width: 164.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        maxLine: 1,
                        height: 1.2,
                        title: product.productName,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),

                      AppText(
                        maxLine: 1,
                        height: 1.2,
                        title: AppLocalizations.of(
                          context,
                        )!.hyundaiCretaVersion,
                        fontSize: 10.sp,

                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Positioned(
        //   right: 14.w,
        //   top: 7.h,
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        //     height: 32.h,
        //     width: 62.w,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10.r),

        //       color: AppColors.cardStackColor,
        //     ),

        //     child: Row(
        //       children: [
        //         Image.asset(AppImage.dollar),
        //         AppText(
        //           title: "500",
        //           fontSize: 12.sp,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

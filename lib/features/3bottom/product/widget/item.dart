import 'package:paint_shop/app/import.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 204.h,
          width: 164.w,
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsetsGeometry.only(
                  top: 8.h,
                  bottom: 8.h,
                  left: 10.w,
                  right: 10.w,
                ),
                width: 164.h,
                height: 144.h,

                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(3.r),
                  child: CachedNetworkImage(
                    cacheManager: MyCacheManager.instance,
                    imageUrl: product.productImage,
                    height: 114.h,
                    width: 128.w,
                    fit: BoxFit.cover,

                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(Icons.error)),
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: SizedBox(height: 114.h, width: 128.w),
                          ),
                        ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    AppText(
                      height: 1,
                      title: product.productName,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      maxLine: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    Gap(10.h),
                    AppText(
                      height: 1,
                      title: product.productId,
                      fontSize: 10.sp,
                      textOverflow: TextOverflow.ellipsis,
                      letterSpacing: 0,

                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 14.w,
          top: 10.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: AppColors.cardStackColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImage.dollar,
                  height: 16.h, // optionally control image size
                ),
                SizedBox(width: 4.w), // space between icon and text
                AppText(
                  title: product.coinReward.toString(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

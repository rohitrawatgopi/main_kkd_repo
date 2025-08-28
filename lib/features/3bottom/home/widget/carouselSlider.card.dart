import 'package:paint_shop/app/import.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<PromotionModel> promotionList;
  final CarouselSliderController carouselController;
  final ValueChanged<int>? onPageChanged;

  const CustomCarouselSlider({
    super.key,
    required this.promotionList,
    required this.carouselController,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carouselController,
      itemCount: promotionList.length,
      itemBuilder: (_, index, __) => ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: CachedNetworkImage(
          cacheManager: MyCacheManager.instance,
          imageUrl: promotionList[index].promotionImage!,
          width: 343.w,
          height: 180.h,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              const CircleAvatar(child: Icon(Icons.error)),
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SizedBox(height: 180.h, width: 343.w),
            ),
          ),
        ),
      ),
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        onPageChanged: (index, reason) {
          if (onPageChanged != null) {
            onPageChanged!(index);
          }
        },
      ),
    );
  }
}

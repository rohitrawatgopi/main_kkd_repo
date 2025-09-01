import 'package:paint_shop/app/import.dart';

class CustomCategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CustomCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<ProductCategoryCubit>().categoryVise(category.id);
        ProductCategoryCubit.pageCategory = 1;
        context.push(
          "/cactegoryProduct",
          extra: {"category": category.id, "screenName": category.categoryName},
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          ClipOval(
            child: CachedNetworkImage(
              cacheManager: MyCacheManager.instance,
              imageUrl: category.categoryImage,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(Icons.error)),
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: CircleAvatar(radius: 80.r),
                ),
              ),
            ),
          ),
          Gap(3.h),
          AppText(
            letterSpacing: 0,
            height: 1,
            textOverflow: TextOverflow.ellipsis,
            title: category.categoryName,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

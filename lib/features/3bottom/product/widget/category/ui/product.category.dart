import 'package:paint_shop/app/import.dart';

class CategoryProductScreen extends StatefulWidget {
  final String categoryName;
  final String? categoryId;
  const CategoryProductScreen({
    super.key,
    required this.categoryName,
    this.categoryId,
  });

  @override
  State<CategoryProductScreen> createState() => _CategoryProductSreenState();
}

class _CategoryProductSreenState extends State<CategoryProductScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = true;
  @override
  void initState() {
    ProductCategoryCubit.pageCategory = 1;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 400 &&
          _isLoadingMore) {
        _isLoadingMore = false;
        context.read<ProductCategoryCubit>().categoryVise(widget.categoryId);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCategoryCubit, ProductCategorySate>(
      builder: (context, state) {
        if (state is ProductCategorySuccess) {
          List<ProductModel> productList = state.products;
          _isLoadingMore = state.paginationModel?.hasMore ?? false;
          return AppContainer(
            child: Column(
              children: [
                Row(
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
                      title: widget.categoryName,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ],
                ),
                Gap(15.h),
                Expanded(
                  child: productList.isEmpty
                      ? Center(
                          child: AppText(
                            title: "Product List Is Empty",
                            color: Colors.black,
                          ),
                        )
                      : MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GridView.builder(
                            itemCount: productList.length + 1,
                            controller: _scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: 5.w,
                                ),
                            itemBuilder: (context, index) {
                              if (index < productList.length) {
                                return InkWell(
                                  onTap: () {},
                                  child: ProductCard(
                                    product: productList[index],
                                  ),
                                );
                              } else {
                                if (state.paginationModel!.hasMore != false) {
                                  return ProductCardShimmer();
                                } else {
                                  return Gap(1);
                                }
                              }
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        }
        return AllProductShimmer();
      },
    );
  }
}

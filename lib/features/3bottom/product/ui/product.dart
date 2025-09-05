import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/product/cubit/product.state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = true;

  @override
  void initState() {
    ProductCubit.page1 = 1;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 400 &&
          _isLoadingMore) {
        _isLoadingMore = false;
        context.read<ProductCubit>().getPageWise();
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
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductFailure) {
          AppToast.error(state.message);
        }
      },
      builder: (context, state) {
        if (state is ProductSuccess) {
          List<ProductModel> productList = state.products;
          _isLoadingMore = state.paginationModel?.hasMore ?? false;

          return RefreshIndicator(
            onRefresh: () async {
              ProductCubit.page1 = 1;
              context.read<ProductCubit>().getPageWise();
            },
            child: AppContainer(
              left: 16.w,
              right: 16.w,

              child: Column(
                children: [
                  AppSearchContainer(
                    ontab: () {
                      showFilterBottomSheet(context);
                    },
                    image: AppImage.filter,
                  ),
                  Gap(15.h),
                  Expanded(
                    flex: 1,
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
                              // your GridView config GridView.builder(
                              controller: _scrollController,
                              itemCount: productList.length + 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.h,
                                    childAspectRatio: 0.86,
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
                                }
                                if (state.paginationModel?.hasMore == true) {
                                  return ProductCardShimmer();
                                } else {
                                  return Center(child: Gap(1.h));
                                }
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        }

        return AllProductShimmer();
      },
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 140.h,
        width: 164.w,
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              child: Container(
                height: 128.h,
                width: 114.w,
                color: Colors.grey[300], // Placeholder box
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Container(
                height: 10.h,
                width: 80.w,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppSearchContainerShimmer extends StatelessWidget {
  const AppSearchContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          Gap(5.w),
          Container(
            width: 287.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36.r),
            ),
            padding: EdgeInsets.fromLTRB(15.w, 11.h, 15.w, 11.h),
            child: Container(
              height: 18.h,
              padding: EdgeInsets.only(left: 10.w, right: 5.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
          Gap(10.w, color: Colors.transparent),

          Container(
            height: 40.h,
            width: 40.w,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ],
      ),
    );
  }
}

class AllProductShimmer extends StatelessWidget {
  const AllProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      child: Column(
        children: [
          Gap(80.h),
          AppSearchContainerShimmer(),

          Gap(35.h),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,

                  childAspectRatio: 0.8,
                  crossAxisSpacing: 6.w,
                ),
                itemBuilder: (context, index) {
                  return InkWell(onTap: () {}, child: ProductCardShimmer());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

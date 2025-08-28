// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/product/widget/search/cubit/search.product.cubit.dart';
import 'package:paint_shop/features/3bottom/product/widget/search/cubit/search.product.state.dart';

class searchProductScreen extends StatefulWidget {
  String screenName;
  searchProductScreen({Key? key, required this.screenName}) : super(key: key);
  @override
  State<searchProductScreen> createState() => _OfferProductSreenState();
}

class _OfferProductSreenState extends State<searchProductScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = true;

  @override
  Widget build(BuildContext context) {
    {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 100 &&
            _isLoadingMore) {
          context.read<ProductSearchCubit>().searchProduct("");
        }
      });
    }

    return BlocBuilder<ProductSearchCubit, ProductSearchSate>(
      builder: (context, state) {
        if (state is ProductSearchSuccess) {
          List<ProductModel> productList = state.products;

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
                      title: widget.screenName,
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
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return const Center(child: Gap(1));
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
        // return Container(
        //   padding: EdgeInsets.all(8.h),
        //   child: Column(
        //     children: [
        //       Gap(45.h),
        //       AppSearchContainerShimmer(),

        //       Gap(15.h),
        //       Expanded(
        //         child: MediaQuery.removePadding(
        //           context: context,
        //           removeTop: true,
        //           child: GridView.builder(
        //             controller: _scrollController,
        //             itemCount: 6,
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 2,
        //               childAspectRatio: 0.8,
        //               crossAxisSpacing: 5.w,
        //             ),
        //             itemBuilder: (context, index) {
        //               return InkWell(onTap: () {}, child: ProductCardShimmer());
        //             },
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }
}

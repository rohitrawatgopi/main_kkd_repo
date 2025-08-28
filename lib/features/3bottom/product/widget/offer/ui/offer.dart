import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/product/widget/offer.product.dart';
import 'package:paint_shop/features/3bottom/product/widget/offer/cubit/category.product.cubit.dart';
import 'package:paint_shop/features/3bottom/product/widget/offer/cubit/category.product.state.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _CategoryProductSreenState();
}

class _CategoryProductSreenState extends State<OfferScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = true;

  @override
  Widget build(BuildContext context) {
    {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 100 &&
            _isLoadingMore) {
          context.read<ProductOfferCubit>().getOffer();
        }
      });
    }

    return BlocBuilder<ProductOfferCubit, ProductOfferSate>(
      builder: (context, state) {
        if (state is ProductOfferSuccess) {
          List<ProductModel> productList = state.products;

          return RefreshIndicator(
            onRefresh: () {
              return context.read<ProductOfferCubit>().getOffer();
            },
            child: AppContainer(
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
                        title: AppLocalizations.of(context)!.offers,
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
                                    childAspectRatio: 0.85,
                                    crossAxisSpacing: 5.w,
                                  ),
                              itemBuilder: (context, index) {
                                if (index < productList.length) {
                                  return InkWell(
                                    onTap: () {},
                                    child: OfferProductCard(
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
                                    return ProductCardLast();
                                  }
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

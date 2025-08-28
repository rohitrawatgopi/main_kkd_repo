import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_shop/core/model/product.dart';
import 'package:paint_shop/features/3bottom/product/widget/category/cubit/category.product.state.dart';
import 'package:paint_shop/features/repo/product.dart';
import 'package:paint_shop/utils/dio.erro.dart';

class ProductCategoryCubit extends Cubit<ProductCategorySate> {
  ProductCategoryCubit() : super(ProductCategoryInitial()) {}

  bool isFetching = false;
  List<ProductModel> allProducts = [];
  static int pageCategory = 1;

  void categoryVise(String? categoryId) async {
    try {
      if (pageCategory == 1) {
        emit(ProductCategoryLoading());
        allProducts.clear();
      }

      final Map<String, dynamic> payload = {
        'category': categoryId,
        'page': pageCategory.toString(),
        'limit': 10.toString(),
      };
      final response = await ProductRepo.getProducts(queryParams: payload);
      if (response.success == true) {
        final newProducts = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        allProducts.addAll(newProducts);

        if (response.pagination?.hasMore == true) {
          pageCategory++;
        }

        emit(ProductCategorySuccess(allProducts, response.pagination));
      } else {
        emit(ProductCategoryFailure(message: response.message!));
      }
    } catch (e) {
      final msg = DioErrorHandler.getErrorMessage(e);

      emit(ProductCategoryFailure(message: msg));
    }
    // }
    //
    //void getOffer() async {
    //    try {
    //   emit(ProductLoading());
    //
    //    final queryParams = {'page': 1.toString()};

    //  final response = await ProductRepo.getOffer(queryParams: queryParams);
    //
    //    if (response.success == true) {
    //      final newProducts = (response.data as List)
    //            .map((e) => ProductModel.fromJson(e))
    //        .toList();
    //
    //       if (response.pagination?.hasMore == true) {}
    //
    //      emit(OfferSuccessS(newProducts, response.pagination));
    //    } else {
    //      emit(ProductFailure(response.message ?? 'Unknown error'));
  }

  //   } catch (e) {
  //     emit(ProductFailure(e.toString()));
  // //   }
  // }
}

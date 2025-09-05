import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_shop/core/model/product.dart';
import 'package:paint_shop/features/3bottom/product/widget/search/cubit/search.product.state.dart';
import 'package:paint_shop/features/repo/product.dart';
import 'package:paint_shop/utils/dio.erro.dart';

class ProductSearchCubit extends Cubit<ProductSearchSate> {
  ProductSearchCubit() : super(ProductSearchInitial());

  bool isFetching = false;
  List<ProductModel> allProductsSearch = [];
  static int page1 = 1;

  void searchProduct(String search, {int limit = 10}) async {
    try {
      if (page1 == 1) {
        allProductsSearch.clear();

        emit(ProductSearchLoading());
      }
      final response = await ProductRepo.getProducts(
        queryParams: {
          'search': search,
          'limit': limit.toString(),
          'page': page1.toString(),
        },
      );
      if (response.success == true) {
        final products = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        allProductsSearch.addAll(products);
        if (response.pagination?.hasMore == true) {
          page1++;
        }

        emit(ProductSearchSuccess(allProductsSearch, response.pagination));
      } else {
        emit(ProductSearchFailure(message: response.message!));
      }
    } catch (e) {
      final msg = DioErrorHandler.getErrorMessage(e);
      emit(ProductSearchFailure(message: msg));
    }
  }
}

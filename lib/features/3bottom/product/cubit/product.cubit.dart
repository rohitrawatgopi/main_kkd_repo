import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_shop/core/model/product.dart' show ProductModel;
import 'package:paint_shop/features/3bottom/product/cubit/product.state.dart';
import 'package:paint_shop/features/repo/product.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial()) {
    getPageWise(page: 1);
  }

  List<ProductModel> allProducts = [];
  static int page1 = 1;

  void getPageWise({int limit = 10, int? page}) async {
    try {
      if (page1 == 1) {
        emit(ProductLoading());
        allProducts.clear();
      }

      final queryParams = {'page': page1.toString(), 'limit': limit.toString()};

      final response = await ProductRepo.getProducts(queryParams: queryParams);

      if (response.success == true) {
        final newProducts = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        allProducts.addAll(newProducts);

        if (response.pagination?.hasMore == true) {
          page1++;
        }

        emit(ProductSuccess(allProducts, response.pagination));
      } else {
        emit(ProductFailure(response.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  } /*  void getAllProducrt() async {
    try {
      emit(ProductLoading());
      final response = await ProductRepo.getProducts();
      if (response.success == true) {
        final products = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        emit(ProductSuccess(products, response.pagination));
      } else {
        emit(ProductFailure(response.message!));
      }
    } catch (e) {
      final msg = DioErrorHandler.getErrorMessage(e);
      emit(ProductFailure(msg));
    }
  }*/
}

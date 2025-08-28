import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_shop/core/model/product.dart';
import 'package:paint_shop/features/3bottom/product/widget/offer/cubit/category.product.state.dart';
import 'package:paint_shop/features/repo/product.dart';
import 'package:paint_shop/utils/dio.erro.dart';

class ProductOfferCubit extends Cubit<ProductOfferSate> {
  ProductOfferCubit() : super(ProductOfferInitial()) {
    getOffer();
  }

  bool isFetching = false;
  List<ProductModel> allProducts = [];
  static int page1 = 1;

  Future<void> getOffer() async {
    try {
      emit(ProductOfferLoading());

      final queryParams = {'page': 1.toString()};

      final response = await ProductRepo.getOffer(queryParams: queryParams);

      if (response.success == true) {
        final newProducts = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        if (response.pagination?.hasMore == true) {}

        emit(ProductOfferSuccess(newProducts, response.pagination));
      } else {
        emit(ProductOfferFailure(message: response.message ?? 'Unknown error'));
      }
    } catch (e) {
      final msg = DioErrorHandler.getErrorMessage(e);

      emit(ProductOfferFailure(message: msg));
    }
  }
}

import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/product/widget/offer/cubit/category.product.state.dart';
import 'package:paint_shop/features/repo/product.dart';
import 'package:paint_shop/utils/dio.erro.dart';

class ProductOfferCubit extends Cubit<ProductOfferSate> {
  ProductOfferCubit() : super(ProductOfferInitial()) {
    getOffer();
  }

  bool isFetching = false;
  List<ProductModel> allProducts = [];
  int page = 1;

  Future<void> getOffer() async {
    if (isFetching) return;
    isFetching = true;

    try {
      final queryParams = {'page': page.toString(), 'limit': '10'};

      if (page == 1) {
        allProducts.clear();
        emit(ProductOfferLoading());
      }

      final response = await ProductRepo.getOffer(queryParams: queryParams);

      if (response.success == true) {
        final newProducts = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        allProducts.addAll(newProducts);

        if (response.pagination?.hasMore == true) {
          page++;
        }

        emit(ProductOfferSuccess(allProducts, response.pagination));
      } else {
        emit(ProductOfferFailure(message: response.message ?? 'Unknown error'));
      }
    } catch (e) {
      final msg = DioErrorHandler.getErrorMessage(e);
      emit(ProductOfferFailure(message: msg));
    } finally {
      isFetching = false;
    }
  }

  Future<void> refreshOffer() async {
    page = 1;
    await getOffer();
  }
}

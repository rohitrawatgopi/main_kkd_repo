import 'package:paint_shop/core/model/product.dart';
import 'package:paint_shop/core/network/response_model.dart';

abstract class ProductCategorySate {}

class ProductCategoryInitial extends ProductCategorySate {}

class ProductCategoryLoading extends ProductCategorySate {}

class ProductCategorySuccess extends ProductCategorySate {
  final List<ProductModel> products;
  final PaginationModel? paginationModel;
  ProductCategorySuccess(this.products, this.paginationModel);
}

class ProductCategoryFailure extends ProductCategorySate {
  final String message;

  ProductCategoryFailure({required this.message});
}

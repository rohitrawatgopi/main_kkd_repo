import 'package:paint_shop/core/model/product.dart';
import 'package:paint_shop/core/network/response_model.dart';

abstract class ProductSearchSate {}

class ProductSearchInitial extends ProductSearchSate {}

class ProductSearchLoading extends ProductSearchSate {}

class ProductSearchSuccess extends ProductSearchSate {
  final List<ProductModel> products;
  final PaginationModel? paginationModel;
  ProductSearchSuccess(this.products, this.paginationModel);
}

class ProductSearchFailure extends ProductSearchSate {
  final String message;

  ProductSearchFailure({required this.message});
}

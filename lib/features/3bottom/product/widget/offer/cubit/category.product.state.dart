import 'package:paint_shop/core/model/product.dart';
import 'package:paint_shop/core/network/response_model.dart';

abstract class ProductOfferSate {}

class ProductOfferInitial extends ProductOfferSate {}

class ProductOfferLoading extends ProductOfferSate {}

class ProductOfferSuccess extends ProductOfferSate {
  final List<ProductModel> products;
  final PaginationModel? paginationModel;
  ProductOfferSuccess(this.products, this.paginationModel);
}

class ProductOfferFailure extends ProductOfferSate {
  final String message;

  ProductOfferFailure({required this.message});
}

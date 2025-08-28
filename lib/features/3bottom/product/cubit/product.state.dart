import 'package:paint_shop/core/model/product.dart';
import 'package:paint_shop/core/network/response_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  final PaginationModel? paginationModel;
  ProductSuccess(this.products, this.paginationModel);
}

class ProductFailure extends ProductState {
  final String message;
  ProductFailure(this.message);
}

class PasswordVisibilityChanged extends ProductState {
  final bool isVisible;
  PasswordVisibilityChanged(this.isVisible);
}

class OfferSuccessS extends ProductState {
  final List<ProductModel> products;
  final PaginationModel? paginationModel;
  OfferSuccessS(this.products, this.paginationModel);
}

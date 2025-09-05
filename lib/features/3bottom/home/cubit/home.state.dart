// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:paint_shop/core/model/category.model.dart';
import 'package:paint_shop/core/model/permotion.dart';
import 'package:paint_shop/core/model/user.model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<CategoryModel> Category;
  final UserModel user;
  final List<PromotionModel> prmotion;
  final int currentIndex;
  HomeSuccess({
    required this.Category,
    required this.user,
    required this.prmotion,
    this.currentIndex = 0,
  });
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}

class UserGetSuccess extends HomeState {
  final UserModel user;
  UserGetSuccess({required this.user});
}

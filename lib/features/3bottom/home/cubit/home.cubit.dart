import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_shop/core/model/category.model.dart';
import 'package:paint_shop/core/model/permotion.dart';
import 'package:paint_shop/core/model/user.model.dart';
import 'package:paint_shop/features/3bottom/home/cubit/home.state.dart';
import 'package:paint_shop/features/repo/home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {}
  UserModel? _user;
  List<CategoryModel>? _categories;
  List<PromotionModel>? _prmotion;
  static List<CategoryModel> resuableCategory = [];
  static UserModel reusableUser = UserModel();

  Future<void> userDetails() async {
    try {
      emit(HomeLoading());
      final response = await HomeRepo.UserDetails();
      if (response.success == true) {
        _user = UserModel.fromJson(response.data);

        reusableUser = _user!;
        // _emitCombinedState();
      }
    } catch (e) {
      emit(HomeFailure("something went wrong"));
    }
  }

  Future<void> userDetailsForProfile() async {
    try {} catch (e) {
      emit(HomeFailure(""));
    }
  }

  Future<void> getCategory() async {
    try {
      final response = await HomeRepo.getCategories();
      if (response.success == true) {
        _categories = (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        resuableCategory = _categories!;
        // _emitCombinedState(); // ← combined emit
      } else {
        emit(HomeFailure(response.message ?? ''));
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> getPrmosion() async {
    try {
      final response = await HomeRepo.getPermotion();
      if (response.success == true) {
        _prmotion = (response.data as List)
            .map((e) => PromotionModel.fromJson(e))
            .toList();
        // _emitCombinedState();
      } else {
        emit(HomeFailure(response.message ?? ''));
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> loadAllHomeData() async {
    try {
      emit(HomeLoading());

      final responses = await Future.wait([
        HomeRepo.UserDetails(),
        HomeRepo.getCategories(),
        HomeRepo.getPermotion(),
      ]);

      final userResponse = responses[0];
      final categoryResponse = responses[1];
      final promotionResponse = responses[2];

      if (userResponse.success == true &&
          categoryResponse.success == true &&
          promotionResponse.success == true) {
        _user = UserModel.fromJson(userResponse.data);
        _categories = (categoryResponse.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        _prmotion = (promotionResponse.data as List)
            .map((e) => PromotionModel.fromJson(e))
            .toList();

        reusableUser = _user!;
        resuableCategory = _categories!;
        print(reusableUser.coinsEarned.toString());
        print(_user!.coinsEarned.toString());
        emit(
          HomeSuccess(
            user: _user!,
            Category: _categories!,
            prmotion: _prmotion!,
          ),
        );
      } else {
        emit(HomeFailure("Some API failed"));
      }
    } catch (e) {
      emit(HomeFailure("Something went wrong: $e"));
    }
  }
}

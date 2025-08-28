import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/network/response_model.dart';
import 'package:paint_shop/core/services/token.hive.dart';
import 'package:paint_shop/features/repo/auth.dart';
import 'package:paint_shop/utils/dio.erro.dart';

class AuthCubit extends Cubit<AuthState> {
  bool isSSecure = true;
  bool istermsChecked = false;
  AuthCubit() : super(AuthInitial()) {
    emit(AuthShowDilog());
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final ResponseModel response = await AuthRepo.login(
        email: email,
        password: password,
      );

      if (response.success == true) {
        await Token.saveToken(response.data['token']);

        emit(AuthSuccess("Login Successfully"));
      } else if (response.success == false) {
        emit(AuthFailure(response.message.toString() ?? 'Login failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    emit(AuthLoading());
    try {
      if (istermsChecked == false) {
        emit(AuthFailure("Please accept Terms & Conditions"));
        return;
      }

      final ResponseModel response = await AuthRepo.SignUp(
        fullName: fullName,
        password: password,
        phone: phone,
        email: email,
      );

      if (response.success == true) {
        emit(AuthSuccess("Signup successful! Please log in to continue."));
      } else if (response.success == false) {
        emit(AuthFailure(response.message ?? 'Singup failed'));
      }
    } catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);

      emit(AuthFailure(errorMessage));
    }
  }

  void toggleSecure() {
    isSSecure = !isSSecure;
    emit(PasswordVisibilityChanged(isSSecure));
  }

  void toggleTerms() {
    istermsChecked = !istermsChecked;
    emit(TermsCheckorNotState(isSSecure));
  }
}

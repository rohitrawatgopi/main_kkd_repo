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

  Future<void> accountDelete() async {
    emit(DeletAccountLoadingState());
    try {
      final ResponseModel response = await AuthRepo.deleteAccount();

      if (response.success == true ||
          response.message ==
              "Your account will be deleted after 7 days unless you log in again.") {
        emit(
          DeletAccountSuccessState(
            msg:
                response.message.toString() ??
                "If you do not log in within 7 days, your account will be permanently deleted.",
          ),
        );
      } else if (response.success == false) {
        emit(
          DeletAccountFailState(
            msg:
                response.message.toString() ??
                'Failed to delete account. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(
        DeletAccountFailState(
          msg: e.toString() ?? "Failed to delete account. Please try again.",
        ),
      );
    }
  }

  Future<void> forgotPassward(String email) async {
    try {
      emit(ForgotButtonLoading());
      final ResponseModel response = await AuthRepo.forgotPassward(email);
      if (response.success == true) {
        emit(ForgotPassSuccess());
      } else {
        emit(ForgotPassFail(response.message ?? "Something Went Wrong"));
      }
    } catch (e) {
      emit(
        ForgotPassFail(
          e.toString() ?? "Failed to delete account. Please try again.",
        ),
      );
    }
  }

  Future<void> verifyOTP(String email, String otp) async {
    try {
      print(email);
      emit(otpVerifyLoading());
      final ResponseModel response = await AuthRepo.verifyOTPRepo(email, otp);
      if (response.success == true) {
        emit(otpVerifySucess());
      } else {
        emit(otpVerifyFail(response.message ?? "Something Went Wrong"));
      }
    } catch (e) {
      emit(
        ForgotPassFail(
          e.toString() ?? "Failed to delete account. Please try again.",
        ),
      );
    }
  }

  Future<void> upadtePassword(String email, String password) async {
    try {
      emit(updatePassLoading());
      final ResponseModel response = await AuthRepo.upadtePassword(
        email,
        password,
      );
      if (response.success == true) {
        emit(updatePassSuccess());
      } else {
        emit(updatePassFail(response.message ?? "Something Went Wrong"));
      }
    } catch (e) {
      emit(
        updatePassFail(
          e.toString() ?? "Failed to delete account. Please try again.",
        ),
      );
    }
  }
}

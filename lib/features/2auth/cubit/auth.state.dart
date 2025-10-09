// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  String? message;
  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class PasswordVisibilityChanged extends AuthState {
  final bool isVisible;
  PasswordVisibilityChanged(this.isVisible);
}

class AuthShowDilog extends AuthState {
  AuthShowDilog();
}

class TermsCheckorNotState extends AuthState {
  final bool istermsChecked;
  TermsCheckorNotState(this.istermsChecked);
}

class DeletAccountLoadingState extends AuthState {}

class ForgotButtonLoading extends AuthState {}

class DeletAccountSuccessState extends AuthState {
  final String msg;

  DeletAccountSuccessState({required this.msg});
}

class DeletAccountFailState extends AuthState {
  final String msg;

  DeletAccountFailState({required this.msg});
}

class ForgotPassFail extends AuthState {
  final String message;
  ForgotPassFail(this.message);
}

class ForgotPassSuccess extends AuthState {
  ForgotPassSuccess();
}

class otpVerifyLoading extends AuthState {
  otpVerifyLoading();
}

class otpVerifySucess extends AuthState {
  otpVerifySucess();
}

class otpVerifyFail extends AuthState {
  final String message;
  otpVerifyFail(this.message);
}

class updatePassLoading extends AuthState {
  updatePassLoading();
}

class updatePassSuccess extends AuthState {
  updatePassSuccess();
}

class updatePassFail extends AuthState {
  final String message;
  updatePassFail(this.message);
}

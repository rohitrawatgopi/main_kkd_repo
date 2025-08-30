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

class DeletAccountSuccessState extends AuthState {
  final String msg;

  DeletAccountSuccessState({required this.msg});
}

class DeletAccountFailState extends AuthState {
  final String msg;

  DeletAccountFailState({required this.msg});
}

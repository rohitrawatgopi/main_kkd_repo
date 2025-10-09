// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:paint_shop/app/import.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String email;
  ChangePasswordScreen({Key? key, required this.email}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is updatePassSuccess) {
            AppToast.success("Your password has been updated successfully!");
            Future.delayed(const Duration(seconds: 1), () {
              context.go('/login');
            });
          }

          if (state is updatePassFail) {
            AppToast.error("Failed to update password. Please try again.");
          }
        },
        builder: (context, state) {
          return AppContainer(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: "Change Password",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  Gap(8.h),
                  AppText(title: "Enter your new password below to reset it."),
                  Gap(20.h),

                  /// New Password
                  AppText(
                    title: "New Password",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  Gap(4.h),
                  AppTextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    hintText: "Enter new password",
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Password is required"),
                      MinLengthValidator(
                        6,
                        errorText: "Password must be at least 6 characters",
                      ),
                    ]).call,
                  ),

                  Gap(16.h),

                  /// Confirm Password
                  AppText(
                    title: "Confirm Password",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  Gap(4.h),
                  AppTextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    hintText: "Re-enter password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please re-enter your password";
                      }
                      if (value != _newPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),

                  Gap(30.h),

                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is updatePassLoading) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.purple,
                            size: 50.0,
                          ),
                        );
                      }
                      return AppButton(
                        title: "Change Password",
                        color: AppColors.textLightColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().upadtePassword(
                              email,
                              _confirmPasswordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

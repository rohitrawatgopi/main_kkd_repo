import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class ForgotPasswardScreen extends StatelessWidget {
  ForgotPasswardScreen({super.key});
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgotPassFail) {
            AppToast.error(state.message);
          }
          if (state is ForgotPassSuccess) {
            AppToast.success("OTP Sent Successfully Please Check Your Email");
            context.push("/otp", extra: _emailController.text);
          }
        },
        child: AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title: "Forgot Your Password ?",
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              Gap(8.h),
              AppText(
                title:
                    "Don’t worry, it happens! Enter your registered email or mobile number and we’ll send you a code to reset your password.",
              ),
              Gap(18.h),
              AppText(
                height: 1.5,
                fontWeight: FontWeight.w500,
                title: AppLocalizations.of(context)!.emailAddress,
                color: Colors.black,
                fontSize: 16.sp,
              ),
              Gap(8.h),
              AppTextField(
                controller: _emailController,
                textHeight: 1.4,
                keyBoardType: TextInputType.emailAddress,
                validator: MultiValidator([
                  MaxLengthValidator(
                    35,
                    errorText: AppLocalizations.of(context)!.emailtoolong,
                  ),
                  EmailValidator(
                    errorText: AppLocalizations.of(context)!.enteravalidemail,
                  ),
                ]).call,
                hintText: AppLocalizations.of(context)!.enterYourEmail,
              ),
              Gap(30.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is ForgotButtonLoading) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.purple,
                            size: 50.0,
                          ),
                        );
                      }
                      return AppButton(
                        color: AppColors.textLightColor,
                        onPressed: () {
                          if (_emailController.text.isEmpty) {
                            AppToast.show(
                              "Please Enter Your Email",
                              ToastStatus.error,
                            );
                          } else if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(_emailController.text)) {
                            AppToast.show(
                              "Please Enter a Valid Email",
                              ToastStatus.error,
                            );
                          } else {
                            context.read<AuthCubit>().forgotPassward(
                              _emailController.text.trim(),
                            );
                          }
                        },
                        title: "Send OTP",
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

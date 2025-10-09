// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paint_shop/app/import.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is otpVerifySucess) {
            context.push("/changePassword", extra: email);
          }
          if (state is otpVerifyFail) {
            AppToast.error(state.message);
          }
        },
        builder: (context, state) {
          return AppContainer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    title: "Enter the 6-digit code sent to your email",
                    textAlign: TextAlign.center,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    length: 6,
                    controller: pinController,
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Gap(20.h),
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
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLightColor,
                            onPressed: () {
                              context.read<AuthCubit>().verifyOTP(
                                email,
                                pinController.text,
                              );
                            },
                            title: "Verify OTP",
                          );
                        },
                      ),

                      Gap(10.h),
                    ],
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

import 'package:flutter/gestures.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/features/2auth/widget/signup.head.dart';
import 'package:paint_shop/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  void _trySingup() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        fullName: _nameController.text.trim(),
        phone: _mobileController.text,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _conPasswordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: AppColors.appColor),
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [Colors.white, AppColors.appColor],
              ),
            ),
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  AppToast.error(state.message);
                } else if (state is AuthSuccess) {
                  AppToast.success(state.message!);

                  context.go('/login');
                }
              },

              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSingupHead(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(20.h),
                            AppText(
                              title: AppLocalizations.of(context)!.fullName,
                              color: Colors.black,
                              fontSize: 16.sp,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                            AppTextField(
                              textHeight: 1.4,
                              hintText: AppLocalizations.of(
                                context,
                              )!.enterYourFullName,
                              controller: _nameController,
                              validator: MultiValidator([
                                MaxLengthValidator(
                                  50,
                                  errorText:
                                      "Name must be less than 50 characters",
                                ),
                                RequiredValidator(
                                  errorText: AppLocalizations.of(
                                    context,
                                  )!.nameisrequired,
                                ),
                              ]).call,
                            ),
                            Gap(13.h),
                            AppText(
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              title: AppLocalizations.of(context)!.emailAddress,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                            AppTextField(
                              textHeight: 1.4,
                              keyBoardType: TextInputType.emailAddress,
                              validator: MultiValidator([
                                MaxLengthValidator(
                                  25,
                                  errorText: "Email too long",
                                ),
                                EmailValidator(
                                  errorText: AppLocalizations.of(
                                    context,
                                  )!.enteravalidemail,
                                ),
                              ]).call,
                              hintText: AppLocalizations.of(
                                context,
                              )!.enterYourEmail,
                              controller: _emailController,
                            ),
                            Gap(13.h),
                            AppText(
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              title: AppLocalizations.of(context)!.mobileNumber,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                            AppTextField(
                              textHeight: 1.4,
                              keyBoardType: TextInputType.phone,
                              validator: MultiValidator([
                                RequiredValidator(
                                  errorText: AppLocalizations.of(
                                    context,
                                  )!.pleasefillmobilenumber,
                                ),
                                PatternValidator(
                                  r'^[0-9]{10}$',
                                  errorText: AppLocalizations.of(
                                    context,
                                  )!.enteravaliddigitmobile,
                                ),
                              ]).call,
                              hintText: AppLocalizations.of(
                                context,
                              )!.enterYourMobileNumber,
                              controller: _mobileController,
                            ),
                            Gap(13.h),
                            AppText(
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              title: AppLocalizations.of(
                                context,
                              )!.createPassword,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),

                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                final cubit = context.read<AuthCubit>();

                                return AppTextField(
                                  textHeight: 1.4,
                                  obscureText: cubit.isSSecure,
                                  maxLines: 1,

                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Required'),
                                    MinLengthValidator(
                                      6,
                                      errorText: 'Min 6 characters',
                                    ),
                                  ]).call,
                                  hintText: AppLocalizations.of(
                                    context,
                                  )!.enterYourPassword,
                                  controller: _passwordController,

                                  surfixIcon: InkWell(
                                    onTap: () => cubit.toggleSecure(),
                                    child: Icon(
                                      size: 18.w,
                                      cubit.isSSecure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Gap(13.h),
                            AppText(
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              title: AppLocalizations.of(
                                context,
                              )!.confirmedPassword,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                            AppTextField(
                              maxLines: 1,
                              obscureText: true,
                              validator: (val) {
                                return MatchValidator(
                                  errorText: AppLocalizations.of(
                                    context,
                                  )!.passwordsdonotmatch,
                                ).validateMatch(
                                  val ?? '',
                                  _passwordController.text.toString(),
                                );
                              },
                              hintText: AppLocalizations.of(
                                context,
                              )!.enterYourPassword,
                              controller: _conPasswordController,
                            ),
                          ],
                        ),
                      ),
                      Gap(13.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(15.w),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              final cubit = context.read<AuthCubit>();
                              return Checkbox(
                                value: cubit.istermsChecked,
                                onChanged: (val) {
                                  context.read<AuthCubit>().toggleTerms();
                                },
                              );
                            },
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Terms & Conditions",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(
                                          Uri.parse(ApiEndpoints.termsPrivacy),
                                        );
                                      },
                                  ),
                                  const TextSpan(text: " and "),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(
                                          Uri.parse(ApiEndpoints.termsPrivacy),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Gap(30.h),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return AppButton(
                                fontHeight: 1.4,
                                color: AppColors.textLightColor,
                                onPressed: _trySingup,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,

                                title: AppLocalizations.of(context)!.signUp,
                              );
                            },
                          ),

                          Gap(13.h),
                          InkWell(
                            onTap: () {
                              context.go("/login");
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: AppText(
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w400,
                                title: AppLocalizations.of(
                                  context,
                                )!.alreadyHaveAnAccount,
                                color: Colors.black,
                                fontSize: 14.sp,
                                height: 1.2,
                              ),
                            ),
                          ),
                          Gap(10.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

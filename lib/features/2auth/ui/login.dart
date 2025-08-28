import 'package:form_field_validator/form_field_validator.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailMobileController = TextEditingController();
  final _passwordController = TextEditingController();

  void _tryLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
        _emailMobileController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailMobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              context.read<HomeCubit>().loadAllHomeData();

              AppToast.success(state.message!);
              context.push("/home");
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              // if (state is AuthShowDilog) {
              //   final currentLocale = context
              //       .read<LanguageCubit>()
              //       .state
              //       .languageCode;
              //   String selectedLang = currentLocale;

              //   return AlertDialog(
              //     backgroundColor: AppColors.appWhite,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     title: const Text('Select Language'),
              //     content: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         RadioListTile<String>(
              //           value: 'en',
              //           groupValue: selectedLang,
              //           title: const Text('English'),
              //           onChanged: (value) {
              //             if (value != null) {
              //               context.read<LanguageCubit>().changeLanguage(value);
              //               // Close dialog
              //               context.read<AuthCubit>().emit(
              //                 AuthInitial(),
              //               ); // Reset
              //             }
              //           },
              //         ),
              //         RadioListTile<String>(
              //           value: 'hi',
              //           groupValue: selectedLang,
              //           title: const Text('हिंदी'),
              //           onChanged: (value) {
              //             if (value != null) {
              //               context.read<LanguageCubit>().changeLanguage(value);
              //               // Close dialog
              //               context.read<AuthCubit>().emit(
              //                 AuthInitial(),
              //               ); // Reset
              //             }
              //           },
              //         ),
              //       ],
              //     ),
              //   );
              // }

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(
                      context,
                    ).size.height, // full screen height
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(72.h),
                                CustomLoginHeaad(),

                                Container(
                                  padding: EdgeInsets.only(
                                    left: 24.w,
                                    right: 24.w,
                                    top: 24.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AppText(
                                        fontWeight: FontWeight.w500,
                                        title: AppLocalizations.of(
                                          context,
                                        )!.emailOrMobile,
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        height: 1.5,
                                      ),
                                      AppTextField(
                                        controller: _emailMobileController,
                                        hintText: AppLocalizations.of(
                                          context,
                                        )!.enterYourEmailOrMobile,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return AppLocalizations.of(
                                              context,
                                            )!.emailormobilenumberisrequired;
                                          }

                                          final emailRegex = RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                          );
                                          final phoneRegex = RegExp(
                                            r'^[0-9]{10}$',
                                          );

                                          if (!emailRegex.hasMatch(
                                                value.trim(),
                                              ) &&
                                              !phoneRegex.hasMatch(
                                                value.trim(),
                                              )) {
                                            return AppLocalizations.of(
                                              context,
                                            )!.enteravalidemailordigitmobilenumber;
                                          }

                                          return null;
                                        },
                                      ),

                                      Gap(13),
                                      AppText(
                                        title: AppLocalizations.of(
                                          context,
                                        )!.password,
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                      ),
                                      BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, state) {
                                          final cubit = context
                                              .read<AuthCubit>();

                                          return AppTextField(
                                            validator: RequiredValidator(
                                              errorText: AppLocalizations.of(
                                                context,
                                              )!.passworisrequired,
                                            ).call,
                                            controller: _passwordController,
                                            hintText: AppLocalizations.of(
                                              context,
                                            )!.enterYourPassword,
                                            obscureText: cubit.isSSecure,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return AppButton(
                                    color: AppColors.textLightColor,
                                    onPressed: _tryLogin,
                                    title: AppLocalizations.of(context)!.login,
                                  );
                                },
                              ),

                              Gap(13.h),
                              InkWell(
                                onTap: () {
                                  context.go("/signup");
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AppText(
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                    title: AppLocalizations.of(
                                      context,
                                    )!.dontHaveAnAccount,
                                    color: Colors.black,
                                    fontSize: 14.sp,
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
              );
            },
          ),
        ),
      ),
    );
  }
}

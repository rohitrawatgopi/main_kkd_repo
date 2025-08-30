// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/profile/cubit/profile.cubit.dart';
import 'package:paint_shop/features/3bottom/profile/cubit/profile.state.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class UdateBankScreen extends StatelessWidget {
  final String updateScreenName;
  final UserModel user;

  UdateBankScreen({
    Key? key,
    required this.updateScreenName,
    required this.user,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const List<String> indianBankShortNames = [
      'SBI',
      'PNB',
      'HDFC',
      'ICICI',
      'AXIS',
      'KOTAK',
      'BOB',
      'CANARA',
      'UNION',
      'BOI',
      'CBI',
      'INDIAN',
      'IDFC',
      'YES',
      'INDUSIND',
      'UCO',
      'IOB',
      'PSB',
      'FEDERAL',
      'SIB',
      'KVB',
      'RBL',
      'BANDHAN',
      'J&K',
      'DHAN',
      'CUB',
      'AU',
      'EQUITAS',
      'ESAF',
      'SURYODAY',
    ];

    final accountNumberController = TextEditingController(
      text: user.accountNumber,
    );
    final accounHolderController = TextEditingController(
      text: user.accountHolderName,
    );
    final bankNameController = TextEditingController(text: user.bankName);
    final IFSCController = TextEditingController(text: user.ifscCode);
    File? file;
    return AppContainer(
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is FilePickefailer) {
            AppToast.error(state.msg);
          }
          if (state is FileUploadSuccess) {
            AppToast.success(state.msg);
            context.pop();
          }
          if (state is FileUploadFail) {
            AppToast.error(state.msg);
          }
        },

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: SizedBox(
                        height: 24.h,
                        width: 34.w,

                        child: SvgPicture.asset(
                          AppImage.backImg,

                          height: 15.h,
                          width: 18.w,
                        ),
                      ),
                    ),
                    Gap(4.w),
                    AppText(
                      title:
                          "${AppLocalizations.of(context)!.uploadYour} ${updateScreenName}",
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ],
                ),

                Gap(5.h),
                // Bank Account Number
                AppTextField(
                  labelText: AppLocalizations.of(context)!.accountNumber,
                  controller: accountNumberController,
                  keyBoardType: TextInputType.number,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Account number is required'),

                    MinLengthValidator(
                      9,
                      errorText: 'Enter valid account number',
                    ),
                    MaxLengthValidator(
                      18,
                      errorText: 'Enter valid account number',
                    ),
                    PatternValidator(
                      r'^[0-9]+$',
                      errorText: 'Only digits allowed',
                    ),
                  ]).call,

                  hintText: AppLocalizations.of(context)!.accountNumber,
                ),

                // Mobile Number (Account Holder)
                AppTextField(
                  labelText: AppLocalizations.of(context)!.accountHolder,
                  controller: accounHolderController,
                  keyBoardType: TextInputType.name,
                  hintText: AppLocalizations.of(context)!.accountHolder,
                  validator: RequiredValidator(
                    errorText: 'Account Holder Name is required',
                  ),
                ),

                AppTextField(
                  surfixIcon: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final cubit = context.read<ProfileCubit>();

                      String? selectedValue;

                      if (state is SlecteBankSuccess) {
                        selectedValue = state.bank;
                      } else {
                        selectedValue = cubit.selectedState;
                      }
                      selectedValue = bankNameController.text.isEmpty
                          ? 'SBI'
                          : bankNameController.text;
                      return DropdownButton<String>(
                        value: selectedValue, // koi value selected nahi
                        hint: const Text(
                          "Select Bank",
                        ), // yeh static hint dikhayega
                        onChanged: (value) {
                          if (value != null) {
                            context.read<ProfileCubit>().selectState(value);
                            bankNameController.text = value;
                          }
                        },
                        items: indianBankShortNames.map((bank) {
                          return DropdownMenuItem(
                            value: bank,
                            child: Text(bank),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  readOnly: true,
                  controller: bankNameController, // use correct controller here
                  hintText: AppLocalizations.of(context)!.bankName,
                  validator: RequiredValidator(
                    errorText: 'Bank Name is required',
                  ),
                ),

                // Pin Code
                AppTextField(
                  labelText: AppLocalizations.of(context)!.ifsc,
                  controller: IFSCController,

                  hintText: AppLocalizations.of(context)!.ifsc,

                  validator: MultiValidator([
                    RequiredValidator(errorText: "IFSC code is required"),
                    PatternValidator(
                      r'^[A-Z]{4}0[A-Z0-9]{6}$',
                      errorText: "Enter valid IFSC code",
                    ),
                  ]).call,
                ),

                Gap(10.h),
                InkWell(
                  onTap: () async {
                    file = await context.read<ProfileCubit>().getFilfle();
                  },
                  child: Container(
                    height: 150.h,
                    width: 341.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.appWhite,
                    ),

                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is FilePickeSuccess) {
                          final file = state.file;
                          final fileExtension = file.path
                              .split('.')
                              .last
                              .toLowerCase();

                          if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
                            return Image.file(file, fit: BoxFit.cover);
                          } else if (fileExtension == 'pdf') {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.picture_as_pdf,
                                  size: 50,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 8),
                                AppText(
                                  title: file.path
                                      .split('/')
                                      .last, // Show filename
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: const Text('Unsupported file format'),
                            );
                          }
                        }

                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              AppText(
                                title: AppLocalizations.of(
                                  context,
                                )!.uploadPassbookImage,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Gap(8.h),
                AppText(
                  title: AppLocalizations.of(context)!.onlyJPGPNG,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
                Gap(20.h),

                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is FileUploadLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return AppButton(
                      width: 341.w,
                      hight: 40.h,
                      radius: 12.w,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (file == null) {
                          AppToast.error(
                            "Please upload a clear photo of your passbook to continue.",
                          );
                        } else {
                          if (_formKey.currentState!.validate()) {
                            await context
                                .read<ProfileCubit>()
                                .updateBankDetails(
                                  accountNumber: accountNumberController.text
                                      .trim(),
                                  accountHolderName: accounHolderController.text
                                      .trim(),
                                  bankName: bankNameController.text.trim(),
                                  ifscCode: IFSCController.text.trim(),
                                  passbookPhoto: file,
                                );

                            context.read<HomeCubit>().userDetailsForProfile();
                          }
                        }
                      },

                      title: AppLocalizations.of(context)!.save,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.buttonColor,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/profile/widget/head.profile.dart';
import 'package:paint_shop/l10n/app_localizations.dart';
import 'package:paint_shop/utils/profile.progress.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeCubit>().state;

    if (state is HomeSuccess) {
      final user = state.user;

      int val = 0;
      if (user.fullName!.isNotEmpty &&
          user.email!.isNotEmpty &&
          user.dob!.isNotEmpty &&
          user.address!.isNotEmpty &&
          user.pinCode!.isNotEmpty &&
          user.state!.isNotEmpty &&
          user.country!.isNotEmpty) {
        val++;
      }
      if (user.aadharVerificationStatus != "incomplete" &&
          user.panVerificationStatus != "incomplete") {
        val++;
      }
      if (user.passbookVerificationStatus != "incomplete" &&
          user.panVerificationStatus != "incomplete") {
        val++;
      }
      return AppContainer(
        left: 0,
        right: 0,
        bottom: 0,
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<HomeCubit>().userDetailsForProfile();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomProfileHead(user: user),
                Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 10.h),
                  child: ProfileProgressContainer(value: val),
                ),
                SectionContainer(
                  user: user,
                  title: AppLocalizations.of(context)!.personalDetails,
                  infoList: [
                    InfoRow(
                      label: AppLocalizations.of(context)!.contactNumber,
                      value: user.phone ?? "ds",
                    ),
                    InfoRow(
                      label: AppLocalizations.of(context)!.emailId,
                      value: user.email ?? '..',
                    ),
                    InfoRow(
                      label: AppLocalizations.of(context)!.dateOfBirth,
                      value: user.dob ?? '..',
                    ),
                    InfoRow(
                      label: AppLocalizations.of(context)!.permanentAddress,
                      value: user.address ?? '.d.',
                    ),
                    InfoRow(
                      label: AppLocalizations.of(context)!.pinCode,
                      value: user.pinCode ?? '..',
                    ),
                    InfoRow(
                      label: AppLocalizations.of(context)!.state,
                      value: user.state ?? '..',
                    ),
                    InfoRow(
                      label: AppLocalizations.of(context)!.country,
                      value: user.country ?? '..',
                    ),
                  ],
                ),

                SectionContainer(
                  user: user,
                  title: AppLocalizations.of(context)!.kyc,
                  infoList: [
                    InfoRow(
                      label: AppLocalizations.of(context)!.panCard,
                      value: user.panVerificationStatus!.isEmpty
                          ? null
                          : user.panVerificationStatus,
                      value2: AppLocalizations.of(context)!.panCard,
                    ),
                    InfoRow(
                      label: AppLocalizations.of(context)!.aadharCard,
                      value: user.aadharVerificationStatus!.isEmpty
                          ? null
                          : user.aadharVerificationStatus,
                      value2: AppLocalizations.of(context)!.aadharCard,
                    ),
                  ],
                ),

                InkWell(
                  onTap: () {},
                  child: SectionContainer(
                    user: user,
                    title: AppLocalizations.of(context)!.bankDetails,
                    infoList: [
                      InfoRow(
                        label: AppLocalizations.of(context)!.accountNumber,
                        value: user.accountNumber!.isEmpty
                            ? ""
                            : user.accountNumber,
                        value2: AppLocalizations.of(context)!.passbook,
                      ),
                      InfoRow(
                        label: AppLocalizations.of(context)!.accountHolder,
                        value: user.accountHolderName!.isEmpty
                            ? ""
                            : user.accountHolderName,
                        value2: AppLocalizations.of(context)!.passbook,
                      ),
                      InfoRow(
                        label: AppLocalizations.of(context)!.bankName,
                        value: user.bankName!.isEmpty ? "" : user.bankName,
                        value2: AppLocalizations.of(context)!.passbook,
                      ),
                      InfoRow(
                        label: AppLocalizations.of(context)!.ifsc,
                        value: user.ifscCode!.isEmpty ? "" : user.ifscCode,
                        value2: AppLocalizations.of(context)!.passbook,
                      ),
                      InfoRow(
                        label: AppLocalizations.of(context)!.passbook,
                        value: user.passbookVerificationStatus!.isEmpty
                            ? ""
                            : user.passbookVerificationStatus,
                        value2: AppLocalizations.of(context)!.passbook,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state is HomeFailure) {
      return Center(child: Text("Something went wrong"));
    }

    return Center(child: SpinKitFadingCircle(color: Colors.purple, size: 50.0));
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String? value2;
  final String? value;

  InfoRow({required this.label, this.value, this.value2});

  @override
  Widget build(BuildContext context) {
    final isValueEmpty =
        value == null ||
        (label == AppLocalizations.of(context)!.panCard &&
            value == "incomplete") ||
        label == AppLocalizations.of(context)!.aadharCard &&
            value == "incomplete" ||
        (value == "incomplete" &&
            label != AppLocalizations.of(context)!.passbook);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isValueEmpty
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: [
        if (isValueEmpty)
          InkWell(
            onTap: () => context.push("/UploadDocumnetScreen", extra: value2),
            child: Icon(Icons.add_circle_outline_rounded, size: 18),
          ),
        if (isValueEmpty) SizedBox(width: 1),

        AppText(title: label, fontSize: 14.sp, fontWeight: FontWeight.w500),

        if (!isValueEmpty) ...[
          Spacer(),
          Flexible(
            child: AppText(
              title: value!,
              maxLine: 1,
              fontSize: 14,
              textOverflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final List<InfoRow> infoList;
  final UserModel user;
  SectionContainer({
    Key? key,
    required this.title,
    required this.infoList,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBgColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.cardBorderLightBlue),
        boxShadow: [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              if (title == AppLocalizations.of(context)!.kyc)
                AppText(title: user.kycStatus!.toString())
              else if (user.passbookVerificationStatus == "incomplete" ||
                  title == AppLocalizations.of(context)!.personalDetails)
                InkWell(
                  onTap: () {
                    if (title ==
                        AppLocalizations.of(context)!.personalDetails) {
                      context.push(
                        "/UdateProfileScreen",
                        extra: {"screenName": title, "user": user},
                      );
                    } else {
                      context.push(
                        "/UdateBankScreen",
                        extra: {"screenName": title, "user": user},
                      );
                    }
                  },
                  child: Icon(Icons.edit),
                )
              else
                const SizedBox.shrink(),
            ],
          ),

          Divider(thickness: 1, color: Colors.black),
          ...infoList,
        ],
      ),
    );
  }
}

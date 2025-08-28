import 'package:intl/intl.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/model/withdrawal.dart';
import 'package:paint_shop/features/3bottom/withdraw/cubit/withdraw.cubit.dart';
import 'package:paint_shop/features/3bottom/withdraw/cubit/withdraw.state.dart';
import 'package:paint_shop/features/3bottom/withdraw/widget/button.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});
  TextEditingController coinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<WithDrawCubit, WithDrawState>(
      listener: (context, state) {
        if (state is WithDrawFailure) {
          AppToast.error(state.message);
        } else if (state is WithDrawSuccess) {
          context.read<WithDrawCubit>().getPandingWithdrawl();
          AppToast.success(state.message);
          coinController.text = "";
        }

        if (state is WithDrawLoading) {
          CircularProgressIndicator();
        }
      },
      child: HomeCubit.reusableUser.coinsEarned == null
          ? Center(child: AppText(title: "Something went wrong "))
          : AppContainer(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            title: AppLocalizations.of(context)!.withdraw,
                            height: 1.6,
                            letterSpacing: -1,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          InkWell(
                            onTap: () {
                              context.push("/trasnactionhistory");
                            },
                            child: Container(
                              height: 44.h,
                              width: 44.w,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),

                                color: Colors.white,
                              ),
                              child: SvgPicture.asset(
                                AppImage.withdrawImg,
                                width: 18.w,
                                height: 16.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppText(
                      textAlign: TextAlign.center,
                      title: HomeCubit.reusableUser.coinsEarned.toString(),
                      fontSize: 28.sp,
                      height: 1,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(6.h),
                    AppText(
                      title: AppLocalizations.of(context)!.availablePoint,
                      fontSize: 14.sp,
                      height: 1,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(26.h),
                    AppText(
                      title: AppLocalizations.of(
                        context,
                      )!.yourWithdrawalRequestIsEncrypted,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      letterSpacing: -0.2,
                      textAlign: TextAlign.center,
                    ),
                    Gap(40.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 32.h,
                      ),
                      height: 267.h,
                      width: 327.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(209, 231, 253, 1),
                            Color.fromRGBO(215, 228, 183, 0.5),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            title: AppLocalizations.of(
                              context,
                            )!.youCanWithdrawUpToPoint,
                            fontSize: 14.sp,
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                          Gap(12.h),
                          AppText(
                            title: AppLocalizations.of(context)!.pointWithdraw,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            letterSpacing: -0.2,
                            height: 1,
                          ),
                          Gap(7.h),
                          AppTextField(
                            controller: coinController,
                            height: 40.h,
                            width: 279.w,
                            maxLines: 1,

                            textSpace: -0.2,
                            keyBoardType: TextInputType.number,
                            hintText: AppLocalizations.of(
                              context,
                            )!.enterPointToWithdraw,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            textHeight: 1,
                          ),
                          Gap(6.h),
                          Gap(6.h),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: AppText(
                              title: "Min: 15,000",

                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              letterSpacing: 0.2,
                            ),
                          ),
                          Gap(8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WithDrawButton(
                                btName: AppLocalizations.of(context)!.clean,
                                onTab: () {
                                  coinController.text = "";
                                },
                              ),
                              WithDrawButton(
                                textColor: AppColors.appWhite,
                                bgColor: AppColors.textLightColor,
                                btName: AppLocalizations.of(context)!.request,
                                onTab: () {
                                  FocusScope.of(context).unfocus();
                                  if (coinController.text.isNotEmpty) {
                                    context.read<WithDrawCubit>().withdrawCoin(
                                      coin: coinController.text,
                                    );
                                  } else {
                                    AppToast.error("enter vaild coin");
                                  }
                                },
                                child:
                                    BlocBuilder<WithDrawCubit, WithDrawState>(
                                      builder: (context, state) {
                                        if (state is WithDrawLoading) {
                                          return Center(
                                            child: AppText(
                                              title: ".......",
                                              color: AppColors.appWhite,
                                              fontSize: 14.sp,
                                              height: 1.5,
                                              letterSpacing: -1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          );
                                        }
                                        return Center(
                                          child: AppText(
                                            title: AppLocalizations.of(
                                              context,
                                            )!.request,
                                            color: AppColors.appWhite,
                                            fontSize: 14.sp,
                                            height: 1.5,
                                            letterSpacing: -1,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        );
                                      },
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(10.h),

                    BlocBuilder<WithDrawCubit, WithDrawState>(
                      builder: (context, state) {
                        if (state is getPandingLoadingRequest) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is getPandingSuccessRequest) {
                          final user = HomeCubit.reusableUser;
                          final List<WithdrawalModel> pendingWithdrawl =
                              state.pandingList;
                          final List<WithdrawalModel> reversedList =
                              pendingWithdrawl.reversed.toList();
                          return SizedBox(
                            height: 200.h,
                            child: reversedList.isEmpty
                                ? AppText(title: "Pending request is empty")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        title:
                                            "Total Pending Reguest ${reversedList.length.toString()}",
                                      ),
                                      Gap(10.h),
                                      Expanded(
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: reversedList.length,
                                          itemBuilder: (context, index) {
                                            final dateTime = DateTime.parse(
                                              reversedList[index].requestedAt
                                                  .toString(),
                                            );
                                            String formatted = DateFormat(
                                              'dd MMMM yyyy',
                                            ).format(dateTime);

                                            return ListTile(
                                              leading: SizedBox(
                                                width: 48.w,
                                                height: 48.h,
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                    cacheManager:
                                                        MyCacheManager.instance,
                                                    imageUrl:
                                                        user.profilePick ??
                                                        "https://dummyimage.com/100x100",
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            CircleAvatar(
                                                              child: Icon(
                                                                Icons.error,
                                                              ),
                                                            ),
                                                    progressIndicatorBuilder:
                                                        (
                                                          context,
                                                          url,
                                                          progress,
                                                        ) => Center(
                                                          child: Shimmer.fromColors(
                                                            baseColor: Colors
                                                                .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[100]!,
                                                            child: CircleAvatar(
                                                              radius: 80.r,
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              title: AppText(
                                                title:
                                                    reversedList[index].user ??
                                                    '',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                              ),
                                              subtitle: AppText(
                                                title: formatted,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.sp,
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    AppImage.dollar,
                                                    height: 20.h,
                                                    width: 20.w,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  AppText(
                                                    title: reversedList[index]
                                                        .amount
                                                        .toString(),
                                                    color: Colors.red,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          );
                        }

                        return Gap(1);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

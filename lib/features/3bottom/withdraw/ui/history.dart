import 'package:intl/intl.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class WithDrawaHistory extends StatelessWidget {
  const WithDrawaHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AppContainer(
        child: RefreshIndicator(
          onRefresh: () async {
            return context.read<HomeCubit>().userDetailsForProfile();
          },
          child: Column(
            children: [
              Gap(20.h),
              Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
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
                    title: AppLocalizations.of(context)!.transactionHistory,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ],
              ),
              Gap(16.h),
              AppText(
                title: HomeCubit.reusableUser.coinsEarned?.toString() ?? "0",
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
                height: 1,
              ),
              AppText(
                title: AppLocalizations.of(context)!.availablePoint,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                height: 1,
              ),
              Gap(10.h),
              TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(text: "Withdraw History"),
                  Tab(text: "Scan History"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // ✅ Withdraw History
                    (HomeCubit.reusableUser.withdrawalHistory == null ||
                            HomeCubit.reusableUser.withdrawalHistory!.isEmpty)
                        ? Center(
                            child: AppText(title: "Withdraw History is empty"),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: HomeCubit
                                .reusableUser
                                .withdrawalHistory!
                                .length,
                            itemBuilder: (context, index) {
                              final reversedList = HomeCubit
                                  .reusableUser
                                  .withdrawalHistory!
                                  .reversed
                                  .toList();
                              final user = HomeCubit.reusableUser;
                              final product = reversedList[index];

                              final dateTime = DateTime.tryParse(
                                product.processedAt.toString() ?? "",
                              );
                              final formatted = dateTime != null
                                  ? DateFormat('dd MMMM yyyy').format(dateTime)
                                  : "";

                              return ListTile(
                                leading: SizedBox(
                                  width: 48.w,
                                  height: 48.h,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      cacheManager: MyCacheManager.instance,
                                      imageUrl:
                                          user.profilePick ??
                                          "https://dummyimage.com/100x100",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                            child: Icon(Icons.error),
                                          ),
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: CircleAvatar(radius: 80.r),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                                title: AppText(
                                  title: user.fullName ?? '',
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
                                      title: product.amount?.toString() ?? '0',
                                      color: Colors.red,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                    // ✅ Scan History
                    (HomeCubit.reusableUser.scanHistory == null ||
                            HomeCubit.reusableUser.scanHistory!.isEmpty)
                        ? Center(child: AppText(title: "Scan History is empty"))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                HomeCubit.reusableUser.scanHistory!.length,
                            itemBuilder: (context, index) {
                              final reversedList = HomeCubit
                                  .reusableUser
                                  .scanHistory!
                                  .reversed
                                  .toList();

                              final product = reversedList[index];

                              return ListTile(
                                leading: SizedBox(
                                  width: 48.w,
                                  height: 48.h,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      cacheManager: MyCacheManager.instance,
                                      imageUrl:
                                          HomeCubit.reusableUser.profilePick ??
                                          "https://dummyimage.com/100x100",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                            child: Icon(Icons.error),
                                          ),
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: CircleAvatar(radius: 80.r),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                                title: AppText(
                                  title: product.productName ?? '',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                                subtitle: AppText(
                                  title: product.categoryName?.toString() ?? '',
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
                                      title:
                                          product.coinsEarned?.toString() ??
                                          '0',
                                      color: Colors.green,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
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
      ),
    );
  }
}

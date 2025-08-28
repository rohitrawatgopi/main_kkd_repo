// import 'package:flutter/material.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/network.check/cubit/networrk.cubit.dart';
import 'package:paint_shop/l10n/app_localizations.dart';
import 'package:paint_shop/utils/bottom_icon.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  final Widget child;
  const BottomNavigationBarScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();

    int getIndex() {
      if (location.startsWith('/product')) return 1;
      if (location.startsWith('/qr')) return 2;
      if (location.startsWith('/withdraw')) return 3;
      if (location.startsWith('/profile')) return 4;
      return 0;
    }

    void onTap(int index) {
      switch (index) {
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/product');
          break;
        case 2:
          context.go('/qr');
          break;
        case 3:
          context.go('/withdraw');
          break;
        case 4:
          context.go('/profile');
          break;
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Scaffold(
        body: BlocBuilder<NetworkCubit, NetworkState>(
          builder: (context, state) {
            if (state is NetworkDisconnected) {
              return InternetBanner();
            }
            if (state is NetworkConnected) {
              return child;
            }
            return Gap(2);
          },
        ),

        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(0, -1))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavIcon(
                asset: AppImage.homeIcon,
                label: AppLocalizations.of(context)!.home,
                isActive: getIndex() == 0,
                onTap: () => onTap(0),
              ),
              NavIcon(
                asset: AppImage.productIcon,
                label: AppLocalizations.of(context)!.product,

                isActive: getIndex() == 1,
                onTap: () => onTap(1),
              ),
              NavIcon(
                asset: AppImage.qrIcon,
                label: AppLocalizations.of(context)!.qrScan,
                isActive: getIndex() == 2,
                onTap: () => onTap(2),
              ),
              NavIcon(
                asset: AppImage.withdrawIcon,
                label: AppLocalizations.of(context)!.withdraw,
                isActive: getIndex() == 3,
                onTap: () {
                  onTap(3);
                  context.read<ProductCubit>().getPageWise();
                },
              ),
              NavIcon(
                asset: AppImage.profileIcon,
                label: AppLocalizations.of(context)!.profile,
                isActive: getIndex() == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InternetBanner extends StatelessWidget {
  const InternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
      builder: (context, state) {
        if (state is NetworkDisconnected) {
          return Container(
            height: double.infinity,

            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.connection,
                  width: 140.h,
                  height: 140.w,
                  fit: BoxFit.cover,
                ),
                Gap(20.h),
                AppText(
                  title: "No Connection ",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                Gap(4.h),
                AppText(
                  height: 1,
                  fontSize: 14.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w300,
                  letterSpacing: .1,
                  title:
                      "Please check your internet connectivity \n and try again",
                ),
                Gap(40.h),
                AppButton(
                  radius: 3.r,
                  hight: 40.h,
                  color: Colors.blue,
                  width: 100,
                  onPressed: () {
                    context.read<NetworkCubit>().checkConnection();
                  },
                  title: "Retry",
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

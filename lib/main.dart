import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/app/router.dart';
import 'package:paint_shop/features/3bottom/product/widget/offer/cubit/category.product.cubit.dart';
import 'package:paint_shop/features/3bottom/product/widget/search/cubit/search.product.cubit.dart';
import 'package:paint_shop/features/3bottom/profile/cubit/profile.cubit.dart';
import 'package:paint_shop/features/3bottom/qr/cubit/qr.cubit.dart';
import 'package:paint_shop/features/3bottom/withdraw/cubit/withdraw.cubit.dart';
import 'package:paint_shop/features/4lang/lang.cubit.dart';
import 'package:paint_shop/features/network.check/cubit/networrk.cubit.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation
        .portraitDown, // optional agar ulta portrait bhi allow karna ho
  ]);
  // debugPaintSizeEnabled = true;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => HomeCubit()..loadAllHomeData()),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => LanguageCubit()..loadSavedLanguage()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => WithDrawCubit()..getPandingWithdrawl()),
        BlocProvider(create: (_) => NetworkCubit()),
        BlocProvider(create: (_) => ScannerCubit()),
        BlocProvider(create: (_) => ProductCategoryCubit()),
        BlocProvider(create: (_) => ProductOfferCubit()),
        BlocProvider(create: (_) => ProductSearchCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: false,
          builder: (context, child) {
            return MaterialApp.router(
              supportedLocales: const [Locale('en'), Locale('hi')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: locale,
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              theme: ThemeData(fontFamily: 'SF Pro'),
              builder: (context, child) {
                return BlocListener<NetworkCubit, NetworkState>(
                  listener: (context, state) {
                    if (state is NetworkDisconnected) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.shade600,
                          duration: const Duration(seconds: 1),
                          content: AppText(
                            title: AppLocalizations.of(
                              context,
                            )!.couldntfindanyavailablenetworks,
                          ),
                          action: SnackBarAction(
                            label: AppLocalizations.of(context)!.retry,
                            textColor: Colors.white,
                            onPressed: () {
                              context.read<NetworkCubit>().checkConnection();
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}

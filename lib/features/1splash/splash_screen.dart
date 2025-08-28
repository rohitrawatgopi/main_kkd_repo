import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/utils/animation_img.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      final box = Hive.box('authBox');
      final token = box.get('token');
      if (token != null && token.toString().isNotEmpty) {
        context.go('/home');
      } else {
        context.go('/LanguageDialog');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.appColor,
                    AppColors.appColor,
                    AppColors.appWhite,
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 101),
                  child: MyAnimatedImage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:hive_flutter/adapters.dart';
// import 'package:paint_shop/app/import.dart';
// import 'package:paint_shop/utils/animation_img.dart';

// class OnboardingScreen extends StatefulWidget  {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
//   late final AnimationController _ctr;
//   late final Animation<double> _animation;
//   @override
//   void initState() {
//     super.initState();
//      _ctr = AnimationController(vsync: this, duration: Duration(seconds: 3))
//       ..repeat();
//     _animation = _ctr;

//     Future.delayed(Duration(seconds: 3), () {
//       final box = Hive.box('authBox');
//       final token = box.get('token');
//       if (token != null && token.toString().isNotEmpty) {
//         context.go('/home');
//       } else {
//         context.go('/login');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion(
//       value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               height: double.infinity.h,
//               width: double.infinity.w,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     AppColors.appColor,
//                     AppColors.appColor,
//                     AppColors.appWhite,
//                   ],
//                 ),
//               ),
//             ),
//             // Column(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Padding(
//             //       padding: const EdgeInsets.only(left: 101),
//             //       child: MyAnimatedImage(),
//             //     ),
//             //   ],
//             // ),
//             AnimatedBuilder(
//       animation: _animation,
//       builder: (_, __) {
//         return CustomPaint(
//           size: Size(300, 300),
//           painter: TreeSplitPainter(progress: _animation.value),
//         );
//       },
//     );
//           ],
//         ),
//       ),
//     );
//   }
// }
// class OnboardingScreen extends StatefulWidget {
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
//   late final AnimationController _ctr;
//   late final Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _ctr = AnimationController(vsync: this, duration: Duration(seconds: 3))
//       ..repeat();
//     _animation = _ctr;
//   }

//   @override
//   void dispose() {
//     _ctr.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (_, __) {
//         return CustomPaint(
//           size: Size(300, 300),
//           painter: TreeSplitPainter(progress: _animation.value),
//         );
//       },
//     );
//   }
// }

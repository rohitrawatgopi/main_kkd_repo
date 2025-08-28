import 'package:paint_shop/app/import.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  const AppContainer({
    super.key,
    required this.child,
    this.right,
    this.bottom,
    this.left,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.appColor],
        ),
      ),
      padding: EdgeInsets.only(
        top: top ?? 64.h,
        left: left ?? 16.w,
        right: right ?? 16.w,
      ),
      child: child,
    );
  }
}

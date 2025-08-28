import 'package:paint_shop/app/import.dart';

class NavIcon extends StatelessWidget {
  String? asset;
  String? label;
  bool? isActive;
  VoidCallback? onTap;

  NavIcon({
    required this.asset,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive! ? Colors.black : Colors.black45;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(asset!, width: 24.w, height: 24.h, color: color),
          SizedBox(height: 4.h),
          AppText(title: label!, fontSize: 12.sp, color: color),
        ],
      ),
    );
  }
}

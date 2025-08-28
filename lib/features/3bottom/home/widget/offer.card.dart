import 'package:paint_shop/app/import.dart';

class CustomOfferCard extends StatelessWidget {
  const CustomOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/offer");
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8.r),
        child: SvgPicture.asset(
          AppImage.special2,
          height: 180.h,
          width: 343.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

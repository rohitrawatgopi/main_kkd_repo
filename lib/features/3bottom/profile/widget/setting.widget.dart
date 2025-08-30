import 'package:paint_shop/app/import.dart';

class SettingWidget extends StatelessWidget {
  String? title;
  String? subtitle;
  SettingWidget({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: title ?? "",
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          AppText(
            title: subtitle ?? "",
            color: Colors.black54,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}

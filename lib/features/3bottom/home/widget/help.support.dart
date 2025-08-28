import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/utils/url_launcher.dart';

void showHelpSupportDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.support_agent, color: Colors.blueAccent),
            SizedBox(width: 8.w),
            AppText(
              title: "Help & Support",
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                EmailLauncher.launchEmail(email: "vinay07wasom@gmail.com");
              },
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.redAccent),
                title: AppText(
                  title: "vinay07wasom@gmail.com",
                  fontSize: 14.sp,
                ),
                subtitle: AppText(
                  title: "Email us your queries",
                  fontSize: 14.sp,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                EmailLauncher.launchDialPad("+91 8077755976");
              },
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.green),
                title: AppText(title: "+91 8077755976", fontSize: 14.sp),
                subtitle: AppText(title: "Call us 24*7", fontSize: 14.sp),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AppText(title: "Close", color: Colors.blueAccent),
          ),
        ],
      );
    },
  );
}

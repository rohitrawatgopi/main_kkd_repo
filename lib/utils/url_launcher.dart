import 'package:url_launcher/url_launcher.dart';

class EmailLauncher {
  static Future<void> launchEmail({required String email}) async {
    launchUrl(Uri(scheme: 'mailto', path: email));
  }

  static Future<void> launchDialPad(String phoneNumber) async {
    launchUrl(Uri(scheme: 'tel', path: phoneNumber));
  }
}

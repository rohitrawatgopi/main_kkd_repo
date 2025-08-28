import 'package:hive_flutter/adapters.dart';

class Token {
  static Future<void> saveToken(String token) async {
    final box = Hive.box('authBox');
    await box.put('token', token);
  }

  static String? getToken() {
    final box = Hive.box('authBox');
    return box.get('token');
  }

  static Future<void> deleteToken() async {
    final box = Hive.box('authBox');
    await box.delete('token');
  }

  static Future<void> clearBox() async {
    final box = Hive.box('authBox');
    await box.delete('token');

    await box.clear();
  }
}

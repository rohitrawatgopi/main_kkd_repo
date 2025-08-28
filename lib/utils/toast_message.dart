import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStatus { success, error, warning, info }

class AppToast {
  static void show(String message, ToastStatus status) {
    Color bgColor;

    switch (status) {
      case ToastStatus.success:
        bgColor = Colors.green;
        break;
      case ToastStatus.error:
        bgColor = Colors.red;
        break;
      case ToastStatus.warning:
        bgColor = Colors.orange;
        break;
      case ToastStatus.info:
        bgColor = Colors.blue;
        break;
    }

    Fluttertoast.cancel(); // cancel old toast if any

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void success(String message) => show(message, ToastStatus.success);
  static void error(String message) => show(message, ToastStatus.error);
  static void warning(String message) => show(message, ToastStatus.warning);
  static void info(String message) => show(message, ToastStatus.info);
}

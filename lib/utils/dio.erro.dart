import 'package:dio/dio.dart';

class DioErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timed out. Please check your internet.";
        case DioExceptionType.sendTimeout:
          return "Request took too long to send.";
        case DioExceptionType.receiveTimeout:
          return "Server is taking too long to respond.";
        case DioExceptionType.badCertificate:
          return "Bad certificate. Connection not secure.";
        case DioExceptionType.badResponse:
          return "Server responded with an error.";
        case DioExceptionType.cancel:
          return "Request was cancelled.";
        case DioExceptionType.connectionError:
          return "Failed to connect. Please check your internet.";
        case DioExceptionType.unknown:
          return "Something went wrong. Please try again.";
      }
    } else {
      return "Unexpected error occurred.";
    }
  }
}

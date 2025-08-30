import 'package:dio/dio.dart';
import 'package:paint_shop/core/network/api_client.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/core/network/response_model.dart';

class AuthRepo {
  // static Future Login({required String email, required String password}) async {
  //   DioClient dioClient = DioClient();

  //   final Response response = await dioClient.post(
  //     ApiEndpoints.loginURL,
  //     data: {"identifier": email, "password": password},
  //   );
  //   final user = ResponseModel.fromJson(response.data);
  //   return response;
  // }

  static Future<ResponseModel> login({
    required String email,
    required String password,
  }) async {
    final dioClient = DioClient();
    final response = await dioClient.post(
      ApiEndpoints.loginURL,
      data: {"identifier": email, "password": password},
    );

    // Parse JSON into your model
    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future SignUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    DioClient dioClient = DioClient();

    final Response response = await dioClient.post(
      ApiEndpoints.singnUpURL,
      data: {
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "password": password,
      },
    );

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future deleteAccount() async {
    DioClient dioClient = DioClient();

    final Response response = await dioClient.delete(
      ApiEndpoints.deleteAccount,
    );

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}

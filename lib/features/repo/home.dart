import 'package:dio/dio.dart';
import 'package:paint_shop/core/network/api_client.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/core/network/response_model.dart';

class HomeRepo {
  static Future<ResponseModel> UserDetails() async {
    DioClient dioClient = DioClient();

    try {
      final Response response = await dioClient.get(ApiEndpoints.getUser);

      // assuming response.data is a Map<String, dynamic>
      final ResponseModel responseModel = ResponseModel.fromJson(response.data);

      return responseModel;
    } catch (e) {
      return ResponseModel(success: false, message: "Error", data: null);
    }
  }

  static Future<ResponseModel> getCategories() async {
    final dioClient = DioClient();
    final response = await dioClient.get(ApiEndpoints.getCategories);

    // Parse JSON into your model
    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<ResponseModel> getPermotion() async {
    final dioClient = DioClient();
    final response = await dioClient.get(ApiEndpoints.getPermotion);

    // Parse JSON into your model
    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}

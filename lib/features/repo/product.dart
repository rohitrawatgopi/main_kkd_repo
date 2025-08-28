import 'package:paint_shop/core/network/api_client.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/core/network/response_model.dart';

class ProductRepo {
  static Future<ResponseModel> getProducts({
    Map<String, dynamic>? queryParams,
  }) async {
    final dioClient = DioClient();

    final response = await dioClient.get(
      ApiEndpoints.product,
      queryParameters: queryParams,
    );

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<ResponseModel> getOffer({
    Map<String, dynamic>? queryParams,
  }) async {
    final dioClient = DioClient();

    final response = await dioClient.get(
      ApiEndpoints.offer,
      queryParameters: queryParams,
    );

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}

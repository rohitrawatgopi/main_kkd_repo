import 'package:dio/dio.dart';
import 'package:paint_shop/core/network/api_client.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/core/network/response_model.dart';

class QrRepo {
  static Future<ResponseModel> scanQr({
    // required String productId,
    // required String type,
    // required int timestamp,
    // required String hash,
    required Map<String, dynamic> data,
  }) async {
    DioClient dioClient = DioClient();

    try {
      final Response response = await dioClient.post(
        ApiEndpoints.qr,
        data: data,
        // data: {
        //   "productId": productId,
        //   "type": type,
        //   "timestamp": timestamp,
        //   "hash": hash,
        // },
      );

      final ResponseModel responseModel = ResponseModel.fromJson(response.data);

      return responseModel;
    } catch (e) {
      return ResponseModel(success: false, message: "Error", data: null);
    }
  }
}

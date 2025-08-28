import 'package:paint_shop/core/network/api_client.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/core/network/response_model.dart';

class WithDrawRepo {
  static Future<ResponseModel> withdraw({required String coin}) async {
    final dioClient = DioClient();
    final response = await dioClient.post(
      ApiEndpoints.withdraw,
      data: {"amount": coin},
    );

    // Parse JSON into your model
    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<ResponseModel> getpanding() async {
    final dioClient = DioClient();
    final response = await dioClient.get(ApiEndpoints.getPandingWithdrawl);

    // Parse JSON into your model
    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}

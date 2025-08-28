import 'dart:io';

import 'package:dio/dio.dart';
import 'package:paint_shop/core/network/api_client.dart';
import 'package:paint_shop/core/network/api_endpoints.dart';
import 'package:paint_shop/core/network/response_model.dart';

class ProfileRepo {
  static Future<ResponseModel> uploadAdhar({required File file}) async {
    final dioClient = DioClient();

    final formData = FormData.fromMap({
      "aadharPhoto": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last,
      ),
    });

    final response = await dioClient.post(ApiEndpoints.aadhar, data: formData);

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<ResponseModel> udateUser({
    File? file,
    required String fullName,
    required String address,
    required String phone,
    required String country,
    required String pinCode,
    required String state,
    required String email,
    required String dob,
  }) async {
    final dioClient = DioClient();

    FormData formData = FormData.fromMap({
      "fullName": fullName.trim(),
      "dob": dob.trim(),
      "address": address.trim(),
      "pinCode": pinCode.trim(),
      "state": state.trim(),
      "country": country.trim(),
      "phone": phone.trim(),
      "email": email.trim(),
      if (file != null)
        "profilePick": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
        ),
    });

    formData.fields.forEach((element) {});

    if (formData.files.isNotEmpty) {
      formData.files.forEach((file) {});
    }

    final response = await dioClient.put(
      ApiEndpoints.updateUser,
      data: formData,
    );

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<ResponseModel> udateBank({
    required String accountNumber,

    required String accountHolderName,
    required String bankName,
    required String ifscCode,
    File? passbookPhoto,
  }) async {
    final dioClient = DioClient();

    FormData formData = FormData.fromMap({
      "accountNumber": accountNumber.trim(),
      "accountHolderName": accountHolderName.trim(),
      "bankName": bankName.trim(),
      "ifscCode": ifscCode.trim(),
      if (passbookPhoto != null)
        "passbookPhoto": await MultipartFile.fromFile(
          passbookPhoto.path,
          filename: passbookPhoto.path.split("/").last,
        ),
    });

    final response = await dioClient.put(
      ApiEndpoints.updateUser,
      data: formData,
    );

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<ResponseModel> uploadpan({required File file}) async {
    final dioClient = DioClient();

    final formData = FormData.fromMap({
      "panPhoto": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last,
      ),
    });

    final response = await dioClient.post(ApiEndpoints.panCard, data: formData);

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<ResponseModel> passbook({required File file}) async {
    final dioClient = DioClient();

    final formData = FormData.fromMap({
      "passbookPhoto": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last,
      ),
    });

    final response = await dioClient.post(
      ApiEndpoints.passbook,
      data: formData,
    );

    return ResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}

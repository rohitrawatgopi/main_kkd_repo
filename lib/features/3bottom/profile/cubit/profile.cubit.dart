import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/network/response_model.dart';
import 'package:paint_shop/features/3bottom/profile/cubit/profile.state.dart';
import 'package:paint_shop/features/repo/profile.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(Profilenitial());

  String? selectedState = "Uttarakhand";
  String? selectedBank = "";
  Future<File?> getFilfle() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    try {
      if (result == null || result.files.isEmpty) {
        emit(FilePickefailer(msg: "No file was selected."));
        return null;
      }

      final extension = result.files.single.extension?.toLowerCase();
      File file = File(result.files.single.path!);

      final fileSize = await file.length();
      if (fileSize > 5242880) {
        emit(FilePickefailer(msg: "File size should not exceed 5 MB"));
        return null;
      } else if (!['jpg', 'png', 'pdf'].contains(extension)) {
        emit(FilePickefailer(msg: "Only JPG, PNG, or PDF files are allowed"));
        return null;
      }

      // 🖼️ Crop only if image
      if (['jpg', 'png'].contains(extension)) {
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          compressQuality: 100,
          aspectRatio: const CropAspectRatio(
            ratioX: 1,
            ratioY: 1,
          ), // 👈 default square crop
          uiSettings: [
            AndroidUiSettings(
              
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.blue.shade500,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: false,
            ),
            IOSUiSettings(title: 'Crop Image'),
          ],
        );

        if (croppedFile != null) {
          file = File(croppedFile.path);
        } else {
          emit(FilePickefailer(msg: "Image cropping was cancelled."));
          return null;
        }
      }

      emit(FilePickeSuccess(file: file));
      return file;
    } catch (e) {
      emit(FilePickefailer(msg: "Error: ${e.toString()}"));
      return null;
    }
  }

  Future<void> upploadAdhar({required File file}) async {
    try {
      emit(FileUploadLoading());
      final ResponseModel response = await ProfileRepo.uploadAdhar(file: file);
      if (response.success == true) {
        emit(
          FileUploadSuccess(
            msg: response.message.toString() ?? "Error file Uloading File",
          ),
        );
      } else if (response.success == false) {
        emit(
          FileUploadFail(
            msg: response.message.toString() ?? "Error file Uloading File",
          ),
        );
      }
    } catch (e) {
      emit(FileUploadFail(msg: "Error file Uloading File"));
    }
  }

  Future<void> upploadPass({required File file}) async {
    try {
      emit(FileUploadLoading());
      final ResponseModel response = await ProfileRepo.passbook(file: file);
      if (response.success == true) {
        emit(
          FileUploadSuccess(
            msg: response.message.toString() ?? "Error file Uloading File",
          ),
        );
      } else if (response.success == false) {
        emit(
          FileUploadFail(
            msg: response.message.toString() ?? "Error file Uloading File",
          ),
        );
      }
    } catch (e) {
      emit(FileUploadFail(msg: "Error file Uloading File"));
    }
  }

  Future<void> upploadPan({required File file}) async {
    try {
      emit(FileUploadLoading());
      final ResponseModel response = await ProfileRepo.uploadpan(file: file);
      if (response.success == true) {
        emit(
          FileUploadSuccess(
            msg: response.message.toString() ?? "Error file Uloading File",
          ),
        );
      } else if (response.success == false) {
        emit(
          FileUploadFail(
            msg: response.message.toString() ?? "Error file Uloading File",
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(FileUploadFail(msg: "Error file Uloading File"));
    }
  }

  Future<void> udateUser({
    File? file,
    required String fullName,
    required String address,
    required String phone,
    required String country,
    required String email,

    required String pinCode,
    required String state,
    required String dob,
  }) async {
    try {
      emit(FileUploadLoading());
      final ResponseModel response = await ProfileRepo.udateUser(
        file: file,
        fullName: fullName,
        email: email,
        address: address,
        phone: phone,
        country: country,
        pinCode: pinCode,
        state: state,
        dob: dob,
      );
      if (response.success == true) {
        emit(
          FileUploadSuccess(
            msg: response.message.toString() ?? "Error while udating user",
          ),
        );
      } else if (response.success == false) {
        emit(
          FileUploadFail(
            msg: response.message.toString() ?? "Error while udating user",
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(FileUploadFail(msg: "Error file Uloading File"));
    }
  }

  Future<void> updateBankDetails({
    required String accountNumber,
    required String accountHolderName,
    required String bankName,
    File? passbookPhoto,
    required String ifscCode,
  }) async {
    try {
      emit(FileUploadLoading());

      final ResponseModel response = await ProfileRepo.udateBank(
        accountNumber: accountNumber,
        accountHolderName: accountHolderName,
        bankName: bankName,
        ifscCode: ifscCode,
        passbookPhoto: passbookPhoto,
      );

      if (response.success == true) {
        emit(
          FileUploadSuccess(
            msg: response.message.toString() ?? "Error while udating user",
          ),
        );
      } else if (response.success == false) {
        emit(
          FileUploadFail(
            msg: response.message.toString() ?? "Error while udating user",
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(FileUploadFail(msg: "Error file Uloading File"));
    }
  }

  void selectState(String state) {
    emit(SlecteStateSuccess(state: state));
  }

  void selectBank(String bank) {
    emit(SlecteBankSuccess(bank: bank));
  }
}

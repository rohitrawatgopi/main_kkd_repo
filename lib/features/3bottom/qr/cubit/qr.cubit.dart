// scanner_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_shop/core/model/qr.model.dart';
import 'package:paint_shop/core/network/response_model.dart';
import 'package:paint_shop/features/3bottom/qr/cubit/qr.state.dart';
import 'package:paint_shop/features/repo/qr.dart';
import 'package:paint_shop/utils/dio.erro.dart';

class ScannerCubit extends Cubit<ScannerState> {
  bool isOn = false;
  ScannerCubit() : super(ScannerInitial()) {}

  Future<void> QrScan({required Map<String, dynamic> value}) async {
    try {
      final payload = {"qrData": value};

      emit(ScannerLoading());

      final ResponseModel response = await QrRepo.scanQr(data: payload);

      if (response.success == true) {
        final coin = response.data?["coinsEarned"]?.toString() ?? '0';

        emit(ScannerSuccess(coin));
      } else {
        QrScanDataModel qr = QrScanDataModel.fromJson(response.data);
        emit(ScannerFailure(qr));
      }
    } catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);

      emit(ScannerError(msg: errorMessage ?? "Something went wrong "));
    }
  }

  void toggleSecure() {
    isOn = !isOn;
    emit(TourchOnState(isOn));
  }
}
  // Future<void> checkCameraPermission() async {
  //   final status = await Permission.camera.status;

  //   if (status.isGranted) {
  //     // Permission already granted — nothing to do
  //     return;
  //   }

  //   if (status.isPermanentlyDenied) {
  //     // User has permanently denied, show dialog and suggest opening settings\      AppToast.success(state.message!);

  //     openAppSettings();
  //     return AppToast.error(
  //       "Camera access is required to scan QR codes. Please enable it from settings.",
  //     );
  //   }

  //   if (status.isDenied) {
  //     final result = await Permission.camera.request();
  //     if (!result.isGranted) {
  //       return AppToast.error(
  //         "Camera permission was denied. You won’t be able to scan QR codes.",
  //       );
  //     }
  //   }
  // }

// scanner_state.dart
import 'package:paint_shop/core/model/qr.model.dart';

abstract class ScannerState {}

class ScannerInitial extends ScannerState {}

class ScannerLoading extends ScannerState {}

class ScannerFaileMessage extends ScannerState {
  final String message;

  ScannerFaileMessage({required this.message});
}

class ScannerSuccess extends ScannerState {
  final String coin;
  ScannerSuccess(this.coin);
}

class ScannerFailure extends ScannerState {
  final QrScanDataModel qrScanDataModel;

  ScannerFailure(this.qrScanDataModel);
}

class ScannerError extends ScannerState {
  final String? msg;
  ScannerError({this.msg});
}

class TourchOnState extends ScannerState {
  final bool isOne;
  TourchOnState(this.isOne);
}

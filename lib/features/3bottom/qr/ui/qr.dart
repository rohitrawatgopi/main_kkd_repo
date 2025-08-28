import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/services/image_picker_service.dart';
import 'package:paint_shop/features/3bottom/qr/cubit/qr.cubit.dart';
import 'package:paint_shop/features/3bottom/qr/cubit/qr.state.dart';
import 'package:paint_shop/utils/reward.dilog.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  late final MobileScannerController _controller = MobileScannerController(
    detectionTimeoutMs: 1000,
    detectionSpeed: DetectionSpeed.normal,
    autoStart: true,
  );

  FilePickerResult? filePickerResult;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerCubit, ScannerState>(
      listener: (ctx, state) async {
        if (state is ScannerFailure) {
          showDialog(
            context: ctx,
            barrierDismissible: false,
            builder: (context) => Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: QrScarrenWidget.unSuccessCoinAlertDilogBox(
                context: context,
                qrScanDataModel: state.qrScanDataModel,
              ),
            ),
          );
        } else if (state is ScannerSuccess) {
          showDialog(
            context: ctx,
            barrierDismissible: false,
            builder: (context) => Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: QrScarrenWidget.succesCoinAlertDilogBox(
                context: context,
                conin: state.coin,
              ),
            ),
          );
          context.read<HomeCubit>().userDetailsForProfile();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            MobileScanner(
              controller: _controller,
              fit: BoxFit.cover,
              useAppLifecycleState: true,
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isNotEmpty) {
                  final String? raw = barcodes.first.rawValue;

                  if (raw != null) {
                    _processQRCode(raw);
                  }
                }
              },
            ),
            Positioned(bottom: 160.h, left: 55.w, child: _buildCornerBorders()),
            BlocBuilder<ScannerCubit, ScannerState>(
              builder: (context, state) {
                if (state is ScannerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            ),
            Positioned(
              bottom: 120.h,
              left: 160.w,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      filePickerResult = await ReusableFilePicker.pickFile();
                      if (filePickerResult != null) {
                        final String filePath =
                            filePickerResult!.files.first.path!;
                        final File file = File(filePath);

                        final BarcodeCapture? capture = await _controller
                            .analyzeImage(file.path);

                        if (capture != null && capture.barcodes.isNotEmpty) {
                          final String? raw = capture.barcodes.first.rawValue;
                          if (raw != null) {
                            _processQRCode(raw);
                          }
                        } else {
                          AppToast.error(
                            "No QR code found in the selected image.",
                          );
                        }
                      }
                    },
                    child: SvgPicture.asset(
                      AppImage.gallery,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                  Gap(15.w),
                  InkWell(
                    onTap: () {
                      _controller.toggleTorch();
                    },
                    child: SvgPicture.asset(
                      "assets/images/flashLight.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processQRCode(String raw) {
    try {
      final Map<String, dynamic> decoded = jsonDecode(raw);
      final payload = {
        "productId": decoded["productId"],
        "type": decoded["type"],
        "timestamp": decoded["timestamp"],
        "hash": decoded["hash"],
      };

      context.read<ScannerCubit>().QrScan(value: payload);
    } catch (e) {
      return AppToast.error("Invalid QR code format. Please scan a valid QR.");
    }
  }

  Widget _buildCornerBorders() {
    return Center(
      child: CustomPaint(
        size: Size(250.w, 250.h),
        painter: CornerBorderPainter(),
      ),
    );
  }
}

class CornerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const double length = 40;
    canvas.drawLine(const Offset(0, 0), const Offset(length, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, length), paint);
    canvas.drawLine(
      Offset(size.width - length, 0),
      Offset(size.width, 0),
      paint,
    );
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, length), paint);
    canvas.drawLine(const Offset(0, 250), const Offset(length, 250), paint);
    canvas.drawLine(const Offset(0, 250), const Offset(0, 250 - length), paint);
    canvas.drawLine(
      Offset(size.width - length, 250),
      Offset(size.width, 250),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 250),
      Offset(size.width, 250 - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

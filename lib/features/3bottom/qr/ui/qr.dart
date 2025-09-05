import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  TextEditingController _cardNumber = TextEditingController();

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
          Future.delayed(Duration(milliseconds: 300), () {
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
                  qrScanDataModel: state.qrScanDataModel!,
                ),
              ),
            );
          });
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
        } else if (state is ScannerFaileMessage) {
          AppToast.error(state.message);
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
            Positioned(bottom: 250.h, left: 65.w, child: _buildCornerBorders()),
            BlocBuilder<ScannerCubit, ScannerState>(
              builder: (context, state) {
                if (state is ScannerLoading) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.purple,
                      size: 50.0,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Positioned(
              bottom: 220.h,
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

            Positioned(
              bottom: 80.h,

              child: SizedBox(
                height: 50.h,
                width: 380.w, // <- yaha .w use kar
                child: AppTextField(
                  borderRadius: 14.r,
                  controller: _cardNumber,
                  hintStyle: const TextStyle(color: Colors.white),
                  textColor: const Color(0xFFA1A1A1),
                  hintText: "Enter Your Card Number",
                  bgColor: const Color(0xFF151515),
                  borderColor: const Color(0xFFF1AF1), // yaha galti thi F1Af1
                  surfixIcon: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 12, 18, 182),
                        minimumSize: Size(
                          40.w,
                          50.h,
                        ), // button ki height/width bhi fix kar
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_cardNumber.text.length != 10) {
                          AppToast.error("Please Enter Valid Code");
                          return;
                        } else {
                          final payload = {"code": _cardNumber.text};
                          context.read<ScannerCubit>().QrScan(value: payload);
                        }
                        _cardNumber.text = "";
                      },
                      child: Icon(
                        Icons.send,
                        color: const Color(0xFFF1F1F1),
                        size: 24.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SvgPicture.string(""),
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

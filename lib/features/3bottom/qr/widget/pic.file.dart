import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ReusableFilePicker {
  static Future<void> pickFileAndScanQR(
    MobileScannerController controller,
  ) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);

      final BarcodeCapture? capture = await controller.analyzeImage(file.path);

      if (capture != null && capture.barcodes.isNotEmpty) {
        final qrCode = capture.barcodes.first.rawValue;

        // TODO: Process qrCode (e.g., send to cubit)
      } else {}
    }
  }
}

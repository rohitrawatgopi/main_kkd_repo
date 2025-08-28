import 'package:file_picker/file_picker.dart';

class ReusableFilePicker {
  static Future<FilePickerResult?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    return result;
  }
}

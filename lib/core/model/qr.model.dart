class QrScanDataModel {
  final String? scannedByName;
  final String? scannedAt;
  final String? productName;
  final String? productImage;

  QrScanDataModel({
    this.scannedByName,
    this.scannedAt,
    this.productName,
    this.productImage,
  });

  factory QrScanDataModel.fromJson(Map<String, dynamic> json) {
    return QrScanDataModel(
      scannedByName: json['scannedByName'],
      scannedAt: json['scannedAt'],
      productName: json['productName'],
      productImage: json['productImage'],
    );
  }
}

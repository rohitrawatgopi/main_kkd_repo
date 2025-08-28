class UserModel {
  final String? id;
  final String? fullName;
  final String? userId;
  final String? phone;
  final String? email;
  final String? profilePick;
  final int? coinsEarned;
  final String? dob;
  final String? address;
  final String? pinCode;
  final String? state;
  final String? country;
  final String? accountNumber;
  final String? accountHolderName;
  final String? bankName;
  final String? ifscCode;
  final String? panPhoto;
  final String? panVerificationStatus;
  final String? panRejectionReason;
  final String? aadharPhoto;
  final String? aadharVerificationStatus;
  final String? aadharRejectionReason;
  final String? passbookPhoto;
  final String? passbookVerificationStatus;
  final String? passbookRejectionReason;
  final String? kycStatus;
  final String? kycRejectionReason;
  final bool? isProfileComplete;
  final List<String>? productsQrScanned;
  final List<ScanHistoryModel>? scanHistory;
  final List<WithdrawalHistoryModel>? withdrawalHistory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? kycRequestDate;
  final DateTime? kycApprovalDate;

  UserModel({
    this.id,
    this.fullName,
    this.userId,
    this.phone,
    this.email,
    this.profilePick,
    this.coinsEarned,
    this.dob,
    this.address,
    this.pinCode,
    this.state,
    this.country,
    this.accountNumber,
    this.accountHolderName,
    this.bankName,
    this.ifscCode,
    this.panPhoto,
    this.panVerificationStatus,
    this.panRejectionReason,
    this.aadharPhoto,
    this.aadharVerificationStatus,
    this.aadharRejectionReason,
    this.passbookPhoto,
    this.passbookVerificationStatus,
    this.passbookRejectionReason,
    this.kycStatus,
    this.kycRejectionReason,
    this.isProfileComplete,
    this.productsQrScanned,
    this.scanHistory,
    this.withdrawalHistory,
    this.createdAt,
    this.updatedAt,
    this.kycRequestDate,
    this.kycApprovalDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullName: json['fullName'],
      userId: json['userId'],
      phone: json['phone'],
      email: json['email'],
      profilePick: json['profilePick'],
      coinsEarned: json['coinsEarned'],
      dob: json['dob'],
      address: json['address'],
      pinCode: json['pinCode'],
      state: json['state'],
      country: json['country'],
      accountNumber: json['accountNumber'],
      accountHolderName: json['accountHolderName'],
      bankName: json['bankName'],
      ifscCode: json['ifscCode'],
      panPhoto: json['panPhoto'],
      panVerificationStatus: json['panVerificationStatus'],
      panRejectionReason: json['panRejectionReason'],
      aadharPhoto: json['aadharPhoto'],
      aadharVerificationStatus: json['aadharVerificationStatus'],
      aadharRejectionReason: json['aadharRejectionReason'],
      passbookPhoto: json['passbookPhoto'],
      passbookVerificationStatus: json['passbookVerificationStatus'],
      passbookRejectionReason: json['passbookRejectionReason'],
      kycStatus: json['kycStatus'],
      kycRejectionReason: json['kycRejectionReason'],
      isProfileComplete: json['isProfileComplete'],
      productsQrScanned: List<String>.from(json['productsQrScanned'] ?? []),
      scanHistory: (json['scanHistory'] as List?)
          ?.map((e) => ScanHistoryModel.fromJson(e))
          .toList(),
      withdrawalHistory: (json['withdrawalHistory'] as List?)
          ?.map((e) => WithdrawalHistoryModel.fromJson(e))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      kycRequestDate: json['kycRequestDate'] != null
          ? DateTime.parse(json['kycRequestDate'])
          : null,
      kycApprovalDate: json['kycApprovalDate'] != null
          ? DateTime.parse(json['kycApprovalDate'])
          : null,
    );
  }
}

class WithdrawalHistoryModel {
  final String? withdrawalId;
  final int? amount;
  final String? status;
  final DateTime? processedAt;
  final String? id;

  WithdrawalHistoryModel({
    this.withdrawalId,
    this.amount,
    this.status,
    this.processedAt,
    this.id,
  });

  factory WithdrawalHistoryModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalHistoryModel(
      withdrawalId: json['withdrawalId'],
      amount: json['amount'],
      status: json['status'],
      processedAt: json['processedAt'] != null
          ? DateTime.parse(json['processedAt'])
          : null,
      id: json['_id'],
    );
  }
}

class ScanHistoryModel {
  final String? productId;
  final String? productName;
  final String? categoryName;
  final int? coinsEarned;
  final String? scannedAt;
  final String? id;

  ScanHistoryModel({
    this.productId,
    this.productName,
    this.categoryName,
    this.coinsEarned,
    this.scannedAt,
    this.id,
  });

  factory ScanHistoryModel.fromJson(Map<String, dynamic> json) {
    return ScanHistoryModel(
      productId: json['productId'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      coinsEarned: json['coinsEarned'],
      scannedAt: json['scannedAt'],
      id: json['_id'],
    );
  }
}

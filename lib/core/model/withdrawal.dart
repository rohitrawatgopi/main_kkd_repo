class WithdrawalModel {
  final String id;
  final String user;
  final int amount;
  final String status;
  final DateTime requestedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  WithdrawalModel({
    required this.id,
    required this.user,
    required this.amount,
    required this.status,
    required this.requestedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalModel(
      id: json['_id'],
      user: json['user'],
      amount: json['amount'],
      status: json['status'],
      requestedAt: DateTime.parse(json['requestedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'amount': amount,
      'status': status,
      'requestedAt': requestedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

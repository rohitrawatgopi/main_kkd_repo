class PromotionModel {
  final String? id;
  final String? promotionName;
  final String? promotionImage;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PromotionModel({
    this.id,
    this.promotionName,
    this.promotionImage,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
    id: json['_id'] as String?,
    promotionName: json['promotionName'] as String?,
    promotionImage: json['promotionImage'] as String?,
    isActive: json['isActive'] as bool?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['_id'] = id;
    if (promotionName != null) map['promotionName'] = promotionName;
    if (promotionImage != null) map['promotionImage'] = promotionImage;
    if (isActive != null) map['isActive'] = isActive;
    if (createdAt != null) map['createdAt'] = createdAt!.toIso8601String();
    if (updatedAt != null) map['updatedAt'] = updatedAt!.toIso8601String();
    if (v != null) map['__v'] = v;
    return map;
  }
}

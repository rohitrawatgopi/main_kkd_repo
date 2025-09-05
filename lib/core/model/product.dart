class ProductModel {
  final String id;
  final String productId;
  final String productName;
  final String description;
  final Category category;
  final int coinReward;
  final String productImage;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.description,
    required this.category,
    required this.coinReward,
    required this.productImage,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'] ?? "",
      category: Category.fromJson(json['category']),
      coinReward: json['coinReward'],
      productImage: json['productImage'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'productName': productName,
      'description': description,
      'category': category.toJson(),
      'coinReward': coinReward,
      'productImage': productImage,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Category {
  final String id;
  final String categoryName;
  final String categoryImage;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
    };
  }
}

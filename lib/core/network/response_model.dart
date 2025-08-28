class ResponseModel {
  bool? success;
  String? message;
  dynamic data;
  PaginationModel? pagination;
  ResponseModel({this.success, this.message, this.data, this.pagination});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data']),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
    );
  }
}

class PaginationModel {
  final int? currentPage;
  final int? totalPages;
  final int? totalProducts;
  final bool? hasMore;

  PaginationModel({
    this.currentPage,
    this.totalPages,
    this.totalProducts,
    this.hasMore,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalProducts: json['totalProducts'],
      hasMore: json['hasMore'],
    );
  }
}

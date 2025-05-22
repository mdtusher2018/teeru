import 'package:trreu/models/common_model.dart';

class CategoryResponse {
  final bool success;
  final int statusCode;
  final String message;
  final CategoryData data;

  CategoryResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: CategoryData.fromJson(json['data']),
    );
  }
}

class CategoryData {
  final PaginationMeta meta;
  final List<Category> result;

  CategoryData({required this.meta, required this.result});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    var list =
        (json['result'] as List).map((e) => Category.fromJson(e)).toList();
    return CategoryData(
      meta: PaginationMeta.fromJson(json['meta']),
      result: list,
    );
  }
}

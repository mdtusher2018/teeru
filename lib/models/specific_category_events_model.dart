import 'package:trreu/models/common_model.dart';

class SpecificCategoryEventsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final SpecificCategoryEventsData data;

  SpecificCategoryEventsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SpecificCategoryEventsResponse.fromJson(Map<String, dynamic> json) {
    return SpecificCategoryEventsResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: SpecificCategoryEventsData.fromJson(json['data']),
    );
  }
}

class SpecificCategoryEventsData {
  final PaginationMeta meta;
  final List<Event> result;

  SpecificCategoryEventsData({required this.meta, required this.result});

  factory SpecificCategoryEventsData.fromJson(Map<String, dynamic> json) {
    return SpecificCategoryEventsData(
      meta: PaginationMeta.fromJson(json['meta']),
      result:
          (json['result'] as List<dynamic>)
              .map((e) => Event.fromJson(e))
              .toList(),
    );
  }
}

import 'package:trreu/models/common_model.dart';

class UpcomingEventsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Event> data;

  UpcomingEventsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UpcomingEventsResponse.fromJson(Map<String, dynamic> json) {
    return UpcomingEventsResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>)
              .map((e) => Event.fromJson(e))
              .toList(),
    );
  }
}

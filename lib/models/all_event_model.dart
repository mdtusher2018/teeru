import 'package:trreu/models/common_model.dart';

class AllEventsModel {
  final bool success;
  final int statusCode;
  final String message;
  final EventData data;

  AllEventsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AllEventsModel.fromJson(Map<String, dynamic> json) {
    return AllEventsModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: EventData.fromJson(json['data']),
    );
  }
}

class EventData {
  final Meta meta;
  final List<Event> result;

  EventData({required this.meta, required this.result});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      meta: Meta.fromJson(json['meta']),
      result: List<Event>.from(json['result'].map((e) => Event.fromJson(e))),
    );
  }
}

class Meta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}

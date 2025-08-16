// sliding_text_model.dart

class SlidingTextResponse {
  bool success;
  int statusCode;
  String message;
  SlidingTextData data;

  SlidingTextResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SlidingTextResponse.fromJson(Map<String, dynamic> json) {
    return SlidingTextResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: SlidingTextData.fromJson(json['data']??{}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class SlidingTextData {
  String id;
  String text;
  bool isActive;

  SlidingTextData({
    required this.id,
    required this.text,
    required this.isActive,
  });

  factory SlidingTextData.fromJson(Map<String, dynamic> json) {
    return SlidingTextData(
      id: json['_id'],
      text: json['text'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'isActive': isActive,
    };
  }
}

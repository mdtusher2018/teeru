class SignupResponse {
  final bool success;
  final int statusCode;
  final String message;
  final SignupData data;

  SignupResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: SignupData.fromJson(json['data']),
    );
  }
}

class SignupData {
  final String createUserToken;

  SignupData({required this.createUserToken});

  factory SignupData.fromJson(Map<String, dynamic> json) {
    return SignupData(createUserToken: json['createUserToken'] ?? '');
  }
}

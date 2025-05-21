class ForgotPasswordOtpResponse {
  final bool success;
  final int statusCode;
  final String message;
  final ForgotPasswordData data;

  ForgotPasswordOtpResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ForgotPasswordOtpResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordOtpResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: ForgotPasswordData.fromJson(json['data']),
    );
  }
}

class ForgotPasswordData {
  final String forgetToken;

  ForgotPasswordData({required this.forgetToken});

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordData(forgetToken: json['forgetToken'] ?? '');
  }
}

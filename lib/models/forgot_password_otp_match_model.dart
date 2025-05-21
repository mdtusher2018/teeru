class ForgotPasswordOtpMatchResponse {
  final bool success;
  final int statusCode;
  final String message;
  final ForgotPasswordOtpMatchData data;

  ForgotPasswordOtpMatchResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ForgotPasswordOtpMatchResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordOtpMatchResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: ForgotPasswordOtpMatchData.fromJson(json['data']),
    );
  }
}

class ForgotPasswordOtpMatchData {
  final String forgetOtpMatchToken;

  ForgotPasswordOtpMatchData({required this.forgetOtpMatchToken});

  factory ForgotPasswordOtpMatchData.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordOtpMatchData(
      forgetOtpMatchToken: json['forgetOtpMatchToken'] ?? '',
    );
  }
}

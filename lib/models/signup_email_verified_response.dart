class SignupEmailVerifiedResponse {
  final bool success;
  final int statusCode;
  final String message;
  final String data; // Token string

  SignupEmailVerifiedResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SignupEmailVerifiedResponse.fromJson(Map<String, dynamic> json) {
    return SignupEmailVerifiedResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] ?? '',
    );
  }
}

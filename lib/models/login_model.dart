class LoginResponse {
  final bool success;
  final int statusCode;
  final String message;
  final LoginData data;

  LoginResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json['success'] ?? false,
    statusCode: json['statusCode'] ?? 0,
    message: json['message'] ?? '',
    data: LoginData.fromJson(json['data']),
  );
}

class LoginData {
  final User user;
  final String accessToken;
  final String refreshToken;

  LoginData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    user: User.fromJson(json['user']),
    accessToken: json['accessToken'] ?? '',
    refreshToken: json['refreshToken'] ?? '',
  );
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String profileImage;
  final String role;
  final String phone;
  final String gender;
  final String coverImage;
  final bool isBlocked;
  final bool isDeleted;
  final String address;
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<dynamic> cards;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.role,
    required this.phone,
    required this.gender,
    required this.coverImage,
    required this.isBlocked,
    required this.isDeleted,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.cards,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'] ?? '',
    fullName: json['fullName'] ?? '',
    email: json['email'] ?? '',
    profileImage: json['profileImage'] ?? '',
    role: json['role'] ?? '',
    phone: json['phone'] ?? '',
    gender: json['gender'] ?? '',
    coverImage: json['coverImage'] ?? '',
    isBlocked: json['isBlocked'] ?? false,
    isDeleted: json['isDeleted'] ?? false,
    address: json['address'] ?? '',
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    v: json['__v'] ?? 0,
    cards: json['cards'] ?? [],
  );
}

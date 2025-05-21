class PasswordResetResponse {
  final bool success;
  final int statusCode;
  final String message;
  final User data;

  PasswordResetResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: User.fromJson(json['data']),
    );
  }
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
  final List<dynamic> cards;
  final String createdAt;
  final String updatedAt;
  final int v;

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
    required this.cards,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      cards: json['cards'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}

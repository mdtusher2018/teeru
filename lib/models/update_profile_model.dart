class UpdateProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final UserProfile data;

  UpdateProfileResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: UserProfile.fromJson(json['data']),
    );
  }
}

class UserProfile {
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

  UserProfile({
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

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
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

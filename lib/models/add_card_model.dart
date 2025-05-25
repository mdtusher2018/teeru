import 'package:trreu/models/common_model.dart';

class AddCardResponse {
  bool success;
  int statusCode;
  String message;
  UserData data;

  AddCardResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AddCardResponse.fromJson(Map<String, dynamic> json) {
    return AddCardResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  String id;
  String fullName;
  String email;
  String profileImage;
  String role;
  String phone;
  String coverImage;
  bool isBlocked;
  bool isDeleted;
  String address;
  List<CardModel> cards;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  UserData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.role,
    required this.phone,
    required this.coverImage,
    required this.isBlocked,
    required this.isDeleted,
    required this.address,
    required this.cards,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    var cardsFromJson = json['cards'] as List;
    List<CardModel> cardList =
        cardsFromJson.map((c) => CardModel.fromJson(c)).toList();

    return UserData(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      profileImage: json['profileImage'],
      role: json['role'],
      phone: json['phone'] ?? '',
      coverImage: json['coverImage'],
      isBlocked: json['isBlocked'],
      isDeleted: json['isDeleted'],
      address: json['address'],
      cards: cardList,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

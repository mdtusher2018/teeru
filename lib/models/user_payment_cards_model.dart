import 'package:trreu/models/common_model.dart';

class UserSpecificPaymentCardsResponse {
  bool success;
  int statusCode;
  String message;
  List<CardModel> cards;

  UserSpecificPaymentCardsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.cards,
  });

  factory UserSpecificPaymentCardsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<CardModel> cardsList = list.map((e) => CardModel.fromJson(e)).toList();

    return UserSpecificPaymentCardsResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      cards: cardsList,
    );
  }
}

import 'dart:developer';

import 'package:trreu/models/add_card_model.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/models/profile_model.dart';
import 'package:trreu/models/user_payment_cards_model.dart';
import 'package:trreu/services/api_service.dart';
import 'package:trreu/utils/ApiEndpoints.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class UserService {
  final ApiService _apiService = ApiService();

  Future<ProfileResponse> fetchProfile() async {
    final response = await _apiService.get(ApiEndpoints.myProfile);

    return ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> updateProfile({
    required Map<String, dynamic> data,
    File? profileImage,
    File? coverImage,
    required String token, // Pass auth token here
  }) async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.updateMyProfile}',
    );
    log('${ApiEndpoints.baseUrl}${ApiEndpoints.updateMyProfile}');
    final request = http.MultipartRequest('PATCH', uri);

    // Add authorization header
    request.headers['token'] = token;

    request.fields['data'] = jsonEncode(data);

    if (profileImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profileImage', profileImage.path),
      );
    }

    if (coverImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('coverImage', coverImage.path),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    log(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      return ProfileResponse.fromJson(json);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  Future<UserSpecificPaymentCardsResponse> getPaymentCards(
    String userId,
  ) async {
    final response = await _apiService.get(ApiEndpoints.myCards);
    return UserSpecificPaymentCardsResponse.fromJson(response);
  }

  Future<AddCardResponse> addCard(CardModel cardRequest) async {
    log('Adding card with body: ${cardRequest.toJson()}');

    final response = await _apiService.post(
      ApiEndpoints.addCard,
      cardRequest.toJson(),
    );

    log('Add card response: $response');

    return AddCardResponse.fromJson(response);
  }
}

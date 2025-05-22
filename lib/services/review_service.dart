import 'package:trreu/models/review_response.dart';
import 'package:trreu/services/api_service.dart';
import 'package:trreu/utils/ApiEndpoints.dart';

class ReviewService {
  final ApiService _apiService = ApiService();

  Future<ReviewResponse> addReview(Map<String, dynamic> reviewData) async {
    final response = await _apiService.post(ApiEndpoints.addReview, reviewData);
    return ReviewResponse.fromJson(response);
  }
}

import 'package:trreu/models/sliding_text_model.dart';
import 'package:trreu/services/api_service.dart';
import 'package:trreu/utils/ApiEndpoints.dart';

class AdsService {
  final ApiService _apiService = ApiService();
  Future<SlidingTextResponse> fetchSlidingText() async {
    final response = await _apiService.get(ApiEndpoints.slidingText);
    return SlidingTextResponse.fromJson(response);
  }

}
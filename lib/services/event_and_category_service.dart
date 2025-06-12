import 'package:trreu/models/all_event_model.dart';
import 'package:trreu/models/category_model.dart';
import 'package:trreu/models/specific_category_events_model.dart';
import 'package:trreu/models/upcoming_events_model.dart';
import 'package:trreu/services/api_service.dart';
import 'package:trreu/utils/ApiEndpoints.dart';

class EventService {
  final ApiService _apiService = ApiService();

  Future<CategoryResponse> fetchCategories() async {
    final response = await _apiService.get(ApiEndpoints.category);
    return CategoryResponse.fromJson(response);
  }

  Future<UpcomingEventsResponse> fetchUpcomingEvents() async {
    final response = await _apiService.get(ApiEndpoints.upcomingEvents);
    return UpcomingEventsResponse.fromJson(response);
  }

  Future<SpecificCategoryEventsResponse> fetchSpecificCategoryEvents(
    String categoryId,
  ) async {
    final endpoint = '${ApiEndpoints.specificCategoryEvent}$categoryId';
    final response = await _apiService.get(endpoint);
    return SpecificCategoryEventsResponse.fromJson(response);
  }

  Future<AllEventsModel> fetchAllEvents() async {
    final response = await _apiService.get(ApiEndpoints.allEvents);
    return AllEventsModel.fromJson(response);
  }
}

import 'package:get/get.dart';
import 'package:trreu/services/event_and_category_service.dart';

import '../models/common_model.dart';

class SportsController extends GetxController {
  final EventService _eventService = EventService();

  var isLoading = false.obs;
  var events = <Event>[].obs;

  final String categoryId;

  SportsController(this.categoryId);

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
      final response = await _eventService.fetchSpecificCategoryEvents(
        categoryId,
      );
      events.value = response.data.result;
    } catch (e) {
      // Handle error, optionally show snackbar
      print('Error fetching category events: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:trreu/services/event_and_category_service.dart';
import 'package:trreu/utils/app_constants.dart';

import '../models/common_model.dart';

class SportsController extends GetxController {
  final EventService _eventService = EventService();

  var isLoading = false.obs;
  var events = <Event>[].obs;

  final String categoryId;
  RxString categoryImage =
      "https://upload.wikimedia.org/wikipedia/commons/8/8d/Lutte_s%C3%A9n%C3%A9galaise_Bercy_2013_-_Mame_Balla-Pape_Mor_L%C3%B4_-_32.jpg"
          .obs;
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
      log(response.data.result.length.toString());
      events.value = response.data.result;
      if (response.data.result.isNotEmpty) {
        categoryImage.value = getFullImageUrl(
          response.data.result.first.category.image,
        );
      }
    } catch (e) {
      // Handle error, optionally show snackbar
      print('Error fetching category events: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/services/event_and_category_service.dart';

class HomeController extends GetxController {
  final EventService _eventService = EventService();

  var isLoadingCategories = false.obs;
  var isLoadingEvents = false.obs;

  var categories = <Category>[].obs;
  var upcomingEvents = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchUpcomingEvents();
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final response = await _eventService.fetchCategories();
      categories.value = response.data.result;
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  Future<void> fetchUpcomingEvents() async {
    try {
      isLoadingEvents.value = true;
      final response = await _eventService.fetchUpcomingEvents();
      upcomingEvents.value = response.data;
    } catch (e) {
      debugPrint('Error fetching upcoming events: $e');
    } finally {
      isLoadingEvents.value = false;
    }
  }
}

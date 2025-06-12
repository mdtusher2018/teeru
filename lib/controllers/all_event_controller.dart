import 'package:get/get.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/services/event_and_category_service.dart';

class AllEventsController extends GetxController {
  final EventService _eventService = EventService();

  var isLoading = false.obs;
  var allEvents = <Event>[].obs;
  var searchResults = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllEvents();
  }

  Future<void> fetchAllEvents() async {
    try {
      isLoading.value = true;
      final response = await _eventService.fetchAllEvents();
      allEvents.value = response.data.result;
      searchResults.value = response.data.result; // initialize with all
    } catch (e) {
      Get.snackbar("Error", "Failed to load events");
    } finally {
      isLoading.value = false;
    }
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      searchResults.value = allEvents;
    } else {
      searchResults.value =
          allEvents
              .where(
                (event) =>
                    event.name.toLowerCase().contains(query.toLowerCase()) ||
                    (event.headToHead).toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    event.location.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
  }
}

import 'package:get/get.dart';
import 'package:trreu/models/user_tickets_model.dart';
import 'package:trreu/services/TicketService.dart';

class MyTicketsController extends GetxController {
  final TicketService _ticketService = TicketService();

  var isLoading = false.obs;
  var tickets = <UserTicket>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserTickets();
  }

  Future<void> fetchUserTickets() async {
    try {
      isLoading.value = true;
      final response = await _ticketService.fetchUserTickets();
      tickets.value = response.data;
    } catch (e) {
      // Handle error
      print("Error fetching tickets: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

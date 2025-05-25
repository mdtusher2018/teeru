import 'package:trreu/models/TicketPurchase_model.dart';
import 'package:trreu/models/user_tickets_model.dart';
import 'package:trreu/services/api_service.dart';
import 'package:trreu/utils/ApiEndpoints.dart';

class TicketService {
  final ApiService _apiService = ApiService();

  Future<TicketPurchaseResponse> buyTickets(Map<String, dynamic> body) async {
    final response = await _apiService.post(ApiEndpoints.buyTicket, body);
    return TicketPurchaseResponse.fromJson(response);
  }

  Future<UserTicketsResponse> fetchUserTickets() async {
    final response = await _apiService.get(ApiEndpoints.myTickets);
    return UserTicketsResponse.fromJson(response);
  }
}

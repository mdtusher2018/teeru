import 'package:get/get.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/services/user_service.dart';

class PaymentMethordController extends GetxController {
  final UserService _userService = UserService();

  var cards = <CardModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserCards();
  }

  Future<void> fetchUserCards() async {
    try {
      isLoading.value = true;
      // Replace with actual userId or get from auth service/localstorage
      String userId = "682d76a4485512ea8b36223f";
      final response = await _userService.getPaymentCards(userId);
      if (response.success) {
        cards.value = response.cards;
      } else {
        cards.clear();
      }
    } catch (e) {
      cards.clear();
    } finally {
      isLoading.value = false;
    }
  }
}

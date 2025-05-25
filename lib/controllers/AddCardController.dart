import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/services/user_service.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class AddCardController extends GetxController {
  final UserService _userService = UserService();

  final cardHolderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expireController = TextEditingController();
  final cvvController = TextEditingController();

  var isLoading = false.obs;

  bool _validate() {
    if (cardHolderNameController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Cardholder name is required',
        backgroundColor: Colors.red,
      );
      return false;
    }
    if (cardNumberController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Card number is required',
        backgroundColor: Colors.red,
      );
      return false;
    }
    if (expireController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Expiry date is required',
        backgroundColor: Colors.red,
      );
      return false;
    }
    if (cvvController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'CVV is required',
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }

  Future<void> addCard() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      // Parsing expiry date into month and year
      final expiryParts = expireController.text.trim().split('/');
      String expiryMonth = expiryParts.length > 0 ? expiryParts[0] : '';
      String expiryYear = expiryParts.length > 1 ? expiryParts[1] : '';

      final request = CardModel(
        cardHolderName: cardHolderNameController.text.trim(),
        cardNumber: cardNumberController.text.trim(),
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        cvv: cvvController.text.trim(),
        cardBrand:
            'Mastercard', // You can enhance this by detecting brand or input field
      );

      final response = await _userService.addCard(request);

      if (response.success) {
        Get.back();
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );
      } else {
        commonSnackbar(
          title: 'Failed',
          message: response.message,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      commonSnackbar(
        title: 'Error',
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    expireController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}

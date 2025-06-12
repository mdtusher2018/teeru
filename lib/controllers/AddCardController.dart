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
    final cardHolderName = cardHolderNameController.text.trim();
    final cardNumber = cardNumberController.text.trim();
    final expiry = expireController.text.trim();
    final cvv = cvvController.text.trim();

    // Cardholder Name: required
    if (cardHolderName.isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Cardholder name is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Card Number: must be 16 digits
    if (cardNumber.isEmpty ||
        cardNumber.length != 16 ||
        !RegExp(r'^\d{16}$').hasMatch(cardNumber)) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Enter a valid 16-digit card number',
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Expiry Date: must be in MM/YY format and in the future
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expiry)) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Expiry date must be in MM/YY format',
        backgroundColor: Colors.red,
      );
      return false;
    } else {
      final parts = expiry.split('/');
      final month = int.tryParse(parts[0]) ?? 0;
      final year = int.tryParse(parts[1]) ?? 0;
      if (month < 1 || month > 12) {
        commonSnackbar(
          title: 'Validation Error',
          message: 'Invalid expiry month',
          backgroundColor: Colors.red,
        );
        return false;
      }
      final now = DateTime.now();
      final fullYear = 2000 + year;
      final expiryDate = DateTime(fullYear, month + 1);
      if (expiryDate.isBefore(now)) {
        commonSnackbar(
          title: 'Validation Error',
          message: 'Card has expired',
          backgroundColor: Colors.red,
        );
        return false;
      }
    }

    // CVV: must be 3 or 4 digits
    if (cvv.isEmpty || !RegExp(r'^\d{3,4}$').hasMatch(cvv)) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Enter a valid CVV (3 or 4 digits)',
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
        cardHolderNameController.clear();
        cardNumberController.clear();
        expireController.clear();
        cvvController.clear();
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

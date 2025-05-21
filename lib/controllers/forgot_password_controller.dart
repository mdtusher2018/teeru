import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/services/auth_service.dart';
import 'package:trreu/services/local_storage_service.dart';
import 'package:trreu/views/auth/otp_page.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  bool _validate() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      errorMessage.value = 'Email is required';
      commonSnackbar(
        title: 'Validation Error',
        message: errorMessage.value,
        backgroundColor: Colors.red,
      );
      return false;
    }
    // Optional: add email format validation here
    return true;
  }

  Future<void> sendOtp() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authService.forgotPasswordOtpByEmail(
        emailController.text.trim(),
      );

      if (response.success) {
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );
        // Save token
        final LocalStorageService _localStorageService = LocalStorageService();
        await _localStorageService.saveToken(response.data.forgetToken);
        // Navigate to OTP page if success
        Get.to(() => OTPScreen());

        // You can save the forgetToken or navigate to OTP verification page here if needed
        // Example: Get.to(() => OtpVerificationScreen(token: response.data.forgetToken));
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
    emailController.dispose();
    super.onClose();
  }
}

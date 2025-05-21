import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/services/auth_service.dart';
import 'package:trreu/views/auth/password_change_successfully.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class OtpVerificationController extends GetxController {
  final AuthService _authService = AuthService();

  final otpController = TextEditingController();

  var isLoading = false.obs;

  // Optional: store email if needed
  late String email;

  void setEmail(String value) {
    email = value;
  }

  bool _validate() {
    if (otpController.text.trim().isEmpty) {
      commonSnackbar(title: 'Validation Error', message: 'OTP is required');
      return false;
    }
    return true;
  }

  Future<void> verifyOtp() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      // Call API — adjust if you need to send email also
      final response = await _authService.forgotPasswordOtpMatch(
        otpController.text.trim(),
      );

      if (response.success) {
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );

        // Navigate to Reset Password Screen with token
        Get.to(() => PasswordChangedSuccessfullyScreen());
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
    otpController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/services/auth_service.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:trreu/views/root_page.dart';

class ResetPasswordController extends GetxController {
  final AuthService _authService = AuthService();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  bool _validate() {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass.isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'New password is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (confirmPass.isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Confirm password is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (newPass != confirmPass) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Passwords do not match',
        backgroundColor: Colors.red,
      );
      return false;
    }

    return true;
  }

  Future<void> resetPassword() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      final response = await _authService.resetPassword(
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      if (response.success) {
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );

        // Navigate to home or login after success
        Get.offAll(() => RootPage());
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
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

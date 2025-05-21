import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/services/auth_service.dart';
import 'package:trreu/views/auth/email_verification_otp_page.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class SignUpController extends GetxController {
  final AuthService _authService = AuthService();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var selectedGender = 'Male'.obs;

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  bool _validate() {
    if (fullNameController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Full name is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Email is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (phoneNumberController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Phone number is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (passwordController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Password is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Confirm password is required',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Passwords do not match',
        backgroundColor: Colors.red,
      );
      return false;
    }

    return true;
  }

  Future<void> signUp() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      final response = await _authService.signup(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneNumberController.text.trim(),
        gender: selectedGender.value.toLowerCase(),
      );

      if (response.success) {
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );

        // Navigate to Signup splash or next page

        Get.to(() => EmailVerifiedOTPScreen());
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
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

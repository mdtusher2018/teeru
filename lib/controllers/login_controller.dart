import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/services/auth_service.dart';
import 'package:trreu/services/local_storage_service.dart';
import 'package:trreu/views/res/commonWidgets.dart'; // Import your commonSnackbar here
import 'package:trreu/views/root_page.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  final LocalStorageService _localStorageService = LocalStorageService();

  final emailController = TextEditingController(text: "user1@gmail.com");
  final passwordController = TextEditingController(text: "hello123");

  var isLoading = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool _validate() {
    bool valid = true;

    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Email or phone is required';
      valid = false;
    } else {
      emailError.value = '';
    }

    if (passwordController.text.trim().isEmpty) {
      passwordError.value = 'Password is required';
      valid = false;
    } else {
      passwordError.value = '';
    }

    return valid;
  }

  Future<void> login() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      final response = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.success) {
        // Save token
        await _localStorageService.saveToken(response.data.accessToken);

        // Navigate to RootPage or home
        Get.offAll(() => RootPage());
      } else {
        commonSnackbar(title: 'Login Failed', message: response.message);
      }
    } catch (e) {
      log(e.toString());
      commonSnackbar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

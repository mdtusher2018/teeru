import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:trreu/services/auth_service.dart';
import 'package:trreu/services/local_storage_service.dart';
import 'package:trreu/views/res/commonWidgets.dart'; // Import your commonSnackbar here
import 'package:trreu/views/root_page.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  final LocalStorageService _localStorageService = LocalStorageService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var address = 'Address Loading...'.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchCurrentAddress();
  }

  Future<void> fetchCurrentAddress() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value = "${place.administrativeArea}, ${place.country}";
        log("User Address: ${address.value}");
      } else {
        address.value = "Address not found";
      }
    } catch (e) {
      debugPrint("Error fetching address: $e");
      address.value = "N/A";
    }
  }

  bool _validate() {
    bool valid = true;

    if (emailController.text.trim().isEmpty) {
      commonSnackbar(title: "Empty", message: 'Email or phone is required');
      emailError.value = 'Email or phone is required';
      valid = false;
    } else {
      emailError.value = '';
    }

    if (passwordController.text.trim().isEmpty) {
      commonSnackbar(title: "Empty", message: 'Password is required');
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
        await _localStorageService.saveRememberMeToken(rememberMe.value);

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
}

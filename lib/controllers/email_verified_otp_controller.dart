import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/services/auth_service.dart';
import 'package:trreu/views/auth/signup_splash.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class EmailVerifiedOtpController extends GetxController {
  final AuthService _authService = AuthService();

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  var isLoading = false.obs;

  String get otp => otpControllers.map((c) => c.text.trim()).join();

  bool _validate() {
    if (otp.length < 6) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Please enter complete 6-digit OTP',
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }

  Future<void> verifyOtp() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      log(otp);

      Map<String, dynamic> userData = {'otp': otp};

      final response = await _authService.signupEmailVerified(userData);

      if (response.success) {
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );
        Get.to(() => SignUpSplashScreen());
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




  Future<void> resendOTP() async {
    try {
      isLoading.value = true;

      log("resend");

      final response = await _authService.resendOtp();

      if (response) {
        commonSnackbar(
          title: 'Success',
          message: "OTP Send Sucessfully",
          backgroundColor: Colors.green,
        );
    
      } else {
        commonSnackbar(
          title: 'Failed',
          message: "OTP couldn't send. Try again letter",
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
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

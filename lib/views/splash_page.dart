import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/services/local_storage_service.dart';
import 'package:trreu/views/auth/login_page.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/root_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    LocalStorageService _localStorageService = LocalStorageService();
    String? token = await _localStorageService.getToken();
    // Navigate to onboarding after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (token != null && token.isNotEmpty) {
        Get.off(RootPage(), transition: Transition.rightToLeft);
      } else {
        Get.off(LoginScreen(), transition: Transition.rightToLeft);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Image.asset("assets/images/logo name.png"),
              SizedBox(height: 20),
              Image.asset('assets/images/logo.png'),
            ],
          ),
        ),
      ),
    );
  }
}

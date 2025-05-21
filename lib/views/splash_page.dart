import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/auth/login_page.dart';
import 'package:trreu/views/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to onboarding after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(LoginScreen());
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

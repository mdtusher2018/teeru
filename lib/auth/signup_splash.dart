import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';
import 'package:trreu/root_page.dart';

class SignUpSplashScreen extends StatefulWidget {
  const SignUpSplashScreen({super.key});

  @override
  State<SignUpSplashScreen> createState() => _SignUpSplashScreenState();
}

class _SignUpSplashScreenState extends State<SignUpSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to onboarding after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(RootPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: FittedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_box, size: 100, color: AppColors.white),
                SizedBox(height: 20),
                commonText(
                  "-Dalal Ak Jàmm-",
                  size: 21,
                  isBold: true,
                  islogoText: true,
                  color: AppColors.white,
                ),
                SizedBox(height: 20),
                commonText(
                  "Your account has been successfully\ncreated. You’re all set to start your\njourney with Teeru.",
                  isBold: true,
                  color: AppColors.white,
                  size: 16,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),
                Image.asset('assets/images/logo.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

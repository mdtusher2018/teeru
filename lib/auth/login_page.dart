// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/auth/forget_password.dart';
import 'package:trreu/auth/signup_page.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';
import 'package:trreu/root_page.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Location and Language
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        commonText("Thies, SN", size: 14),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage(
                        'assets/images/france.png',
                      ), // French flag icon
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),

                // Log In Title
                commonText("Log In", size: 18, fontWeight: FontWeight.bold),
                const SizedBox(height: 16),

                // Email / Phone
                commonTextfield(
                  hintText: "Enter Email or Phone Number",
                  emailController,
                ),
                const SizedBox(height: 12),

                // Password
                commonTextfield(
                  passwordController,

                  hintText: "Password",
                  issuffixIconVisible: true,
                  isPasswordVisible: isPasswordVisible,
                  changePasswordVisibility: () {
                    isPasswordVisible = !isPasswordVisible;
                    setState(() {});
                  },
                ),

                // Remember me & Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (val) {
                            rememberMe = !rememberMe;
                            setState(() {});
                          },
                        ),
                        commonText("Keep me logged in", size: 14),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ForgetPasswordScreen());
                      },
                      child: commonText(
                        "Forgot password?",
                        size: 14,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Log In Button
                commonButton(
                  "Log In",
                  onTap: () {
                    Get.to(RootPage());
                  },
                ),

                const SizedBox(height: 16),

                // Sign Up / Guest
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        commonText("New to Teeru? "),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignUpScreen());
                          },
                          child: commonText(
                            "Let’s get started",

                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(RootPage());
                      },
                      child: commonText(
                        "Continue as guest",
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

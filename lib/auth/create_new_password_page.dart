// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/auth/login_page.dart';
import 'package:trreu/res/commonWidgets.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Logo
              Image.asset('assets/images/full_logo.png'),
              const SizedBox(height: 8),

              // Teeru Title and Subtitle
              const SizedBox(height: 2),

              // Title

              // Password Rules
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Create a New Password", size: 16, isBold: true),
                  PasswordRichText(
                    normalText: "At least ",
                    boldText: "11 characters",
                  ),
                  PasswordRichText(
                    normalText: "At least ",
                    boldText: "one number",
                  ),
                  PasswordRichText(
                    normalText: "At least ",
                    boldText: "one symbol",
                    tailText: " (e.g., ! @ # \$)",
                  ),
                  PasswordRichText(
                    boldText: "Uppercase & lowercase",
                    tailText: " letters",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // New Password Field
              commonTextfield(
                newPasswordController,
                hintText: "New Password",
                issuffixIconVisible: true,
                isPasswordVisible: isNewPasswordVisible,
                changePasswordVisibility: () {
                  isNewPasswordVisible = !isNewPasswordVisible;
                  setState(() {});
                },
              ),
              const SizedBox(height: 12),

              // Confirm Password Field
              commonTextfield(
                confirmPasswordController,
                hintText: "Confirm Password",
                issuffixIconVisible: true,
                isPasswordVisible: isConfirmPasswordVisible,
                changePasswordVisibility: () {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),

              // Save Password Button
              commonButton(
                "Save Password",
                onTap: () {
                  Get.to(LoginScreen());
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordRule(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          commonText("• ", size: 14, isBold: true),
          Expanded(child: commonText(text, size: 14, isBold: true)),
        ],
      ),
    );
  }
}

class PasswordRichText extends StatelessWidget {
  final String? normalText;
  final String boldText;
  final String? tailText;

  const PasswordRichText({
    super.key,
    this.normalText,
    required this.boldText,
    this.tailText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: "• ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (normalText != null) TextSpan(text: normalText),
              TextSpan(
                text: boldText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (tailText != null) TextSpan(text: tailText),
            ],
          ),
        ),
      ],
    );
  }
}

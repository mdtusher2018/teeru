// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:trreu/controllers/reset_password_controller.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({Key? key}) : super(key: key);

  // Inject controller
  final ResetPasswordController controller = Get.put(ResetPasswordController());

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

              // Title and rules
              const SizedBox(height: 2),
              commonText("Create a New Password", size: 16, isBold: true),
              PasswordRichText(
                normalText: "At least ",
                boldText: "11 characters",
              ),
              PasswordRichText(normalText: "At least ", boldText: "one number"),
              PasswordRichText(
                normalText: "At least ",
                boldText: "one symbol",
                tailText: " (e.g., ! @ # \$)",
              ),
              PasswordRichText(
                boldText: "Uppercase & lowercase",
                tailText: " letters",
              ),
              const SizedBox(height: 20),

              // New Password Field
              Obx(
                () => commonTextfield(
                  controller.newPasswordController,
                  hintText: "New Password",
                  issuffixIconVisible: true,
                  isPasswordVisible:
                      controller.isLoading.value
                          ? false
                          : controller.isPasswordVisible.value,
                  changePasswordVisibility: () {
                    controller.isPasswordVisible.value =
                        !controller.isPasswordVisible.value;
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Confirm Password Field
              Obx(
                () => commonTextfield(
                  controller.confirmPasswordController,
                  hintText: "Confirm Password",
                  issuffixIconVisible: true,
                  isPasswordVisible:
                      controller.isLoading.value
                          ? false
                          : controller.isConfirmPasswordVisible.value,
                  changePasswordVisibility: () {
                    controller.isConfirmPasswordVisible.value =
                        !controller.isConfirmPasswordVisible.value;
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Save Password Button
              Obx(
                () => commonButton(
                  controller.isLoading.value ? "Saving..." : "Save Password",
                  onTap:
                      controller.isLoading.value
                          ? null
                          : () {
                            controller.resetPassword();
                          },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
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

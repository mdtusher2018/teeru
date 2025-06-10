import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/forgot_password_controller.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  // Use GetX controller
  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              Column(
                children: [
                  commonText("Forgot Password".tr, size: 16, isBold: true),
                  SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: commonText(
                      "Enter email or phone number to send one time OTP Verification code"
                          .tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Use controller's emailController
                  commonTextfield(
                    controller.emailController,
                    hintText: "Enter Email or Phone Number".tr,
                  ),

                  const SizedBox(height: 20),

                  Obx(
                    () => commonButton(
                      controller.isLoading.value
                          ? "Sending...".tr
                          : "Generate OTP".tr,
                      height: 40,
                      onTap:
                          controller.isLoading.value
                              ? null
                              : () async {
                                await controller.sendOtp();
                              },
                    ),
                  ),

                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: commonText("Cancel".tr, size: 18, isBold: true),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Image.asset("assets/images/full_logo.png"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

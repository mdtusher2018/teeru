// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/email_verified_otp_controller.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class EmailVerifiedOTPScreen extends StatelessWidget {
  EmailVerifiedOTPScreen({super.key});

  final EmailVerifiedOtpController controller = Get.put(
    EmailVerifiedOtpController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: BackButton(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              commonText("OTP Verification".tr, size: 18, isBold: true),
              SizedBox(height: 8),
              SizedBox(
                width: 200,
                child: commonText(
                  "We’ve sent a 6-digit code to your email/phone number.\nPlease enter the code below to continue."
                      .tr,
                  size: 14,
                  textAlign: TextAlign.center,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.otpControllers.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: buildOTPTextField(
                      controller.otpControllers[index],
                      index,
                      context,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              commonButton(
                controller.isLoading.value ? "Verifying...".tr : "Verify".tr,
                onTap:
                    controller.isLoading.value
                        ? null
                        : () async {
                          await controller.verifyOtp();
                        },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  children: [
                    commonText("Didn’t get the code?".tr, isBold: true),
                    GestureDetector(
                      onTap: () {
                        controller.resendOTP();
                      },
                      child: commonText(
                        "Resend".tr,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: commonText(
                        "Cancel".tr,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

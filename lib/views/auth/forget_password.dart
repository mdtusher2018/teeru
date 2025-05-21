// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/auth/otp_page.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  ForgetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                commonText("Forgot Password", size: 16, isBold: true),
                SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: commonText(
                    "Enter email or phone number to send one time OTP Verification code",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                commonTextfield(
                  hintText: "Enter Email or Phone Number",
                  emailController,
                ),
                const SizedBox(height: 20),
                commonButton(
                  "Generate OTP",
                  height: 40,
                  onTap: () {
                    Get.to(OTPScreen());
                  },
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: commonText("Cancel", size: 18, isBold: true),
                ),
              ],
            ),
            SizedBox(height: 20),
            Image.asset("assets/images/full_logo.png"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Function to open the email client with the given email
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class SplashPasswordPage extends StatelessWidget {
  const SplashPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: commonText(
                "Congratulation! You have been successfully authenticate.".tr,
                isBold: true,
                size: 14,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            commonButton("Continue".tr),
          ],
        ),
      ),
    );
  }
}

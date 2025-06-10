// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/add_card.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class RedeemCodeScreen extends StatelessWidget {
  RedeemCodeScreen({super.key});

  TextEditingController redeemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        "Redeem Code".tr,
        color: AppColors.primaryColor,
        textcolor: AppColors.white,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Enter Code".tr, size: 16),
            SizedBox(height: 8),
            commonTextfield(
              redeemController,
              prefixIcon: Image.asset(
                "assets/icons/giftcard.png",
                color: AppColors.black,
              ),
              borderColor: AppColors.white,
              hintText: "Type here".tr,
            ),
            SizedBox(height: 24),
            commonButton(
              "Add New Card".tr,
              onTap: () {
                Get.to(AddCardPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

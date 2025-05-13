import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/add_card.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';

class PaymentOptionScreen extends StatelessWidget {
  const PaymentOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        "Payment Methods",
        color: AppColors.primaryColor,
        textcolor: AppColors.white,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Cards", size: 16, isBold: true, color: AppColors.white),
            SizedBox(height: 8),
            cardDesign(cardName: "Card", path: "assets/images/mastercard.png"),
            SizedBox(height: 16),
            cardDesign(cardName: "Card", path: "assets/images/mastercard.png"),
            SizedBox(height: 24),
            commonButton("Add New Card"),
          ],
        ),
      ),
    );
  }

  Widget cardDesign({required String cardName, required String path}) {
    return InkWell(
      onTap: () {
        Get.to(AddCardPage());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [commonText(cardName, size: 14), Image.asset(path)],
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class AddCardPage extends StatelessWidget {
  AddCardPage({super.key});

  TextEditingController cardHolderNameController = TextEditingController();

  TextEditingController cardNumberController = TextEditingController();

  TextEditingController expireController = TextEditingController();

  TextEditingController CVVController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: commonAppBar("New Card", color: AppColors.primaryColor),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 180,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage("assets/images/Master_Card.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 16),
            commonTextfield(
              cardHolderNameController,
              hintText: "Cardholder Name",
            ),
            SizedBox(height: 16),

            commonTextfield(cardNumberController, hintText: "Card Number"),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: commonTextfield(expireController, hintText: "MM/YY"),
                ),
                Spacer(),
                Expanded(
                  child: commonTextfield(CVVController, hintText: "CVV"),
                ),
              ],
            ),
            SizedBox(height: 16),
            commonButton("Add Card"),
          ],
        ),
      ),
    );
  }
}

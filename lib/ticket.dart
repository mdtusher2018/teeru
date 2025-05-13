import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/home_page.dart';
import 'package:trreu/res/commonWidgets.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText(
          "My Tickets",
          size: 18,
          isBold: true,
          color: AppColors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: SizedBox(),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset("assets/images/ticket.png"),
            Spacer(),
            commonButton(
              "Discover Events",
              onTap: () {
                Get.to(HomePage());
              },
            ),
            Spacer(),
            Image.asset('assets/images/full_logo.png'),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

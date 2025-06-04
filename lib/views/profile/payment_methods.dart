import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/payment_methord_controller.dart';
import 'package:trreu/views/add_card.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class PaymentMethordScreen extends StatelessWidget {
  PaymentMethordScreen({Key? key}) : super(key: key);

  final PaymentMethordController controller = Get.put(
    PaymentMethordController(),
  );

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(
                "Cards",
                size: 16,
                isBold: true,
                color: AppColors.white,
              ),
              SizedBox(height: 8),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.cards.isEmpty) {
                  return commonText(
                    "No cards found.",
                    color: AppColors.white,
                    size: 14,
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.cards.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final card = controller.cards[index];
                    return cardDesign(
                      cardName:
                          '${card.cardBrand} •••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                      path: _getCardImagePath(card.cardBrand),
                    );
                  },
                );
              }),
              SizedBox(height: 24),
              commonButton(
                "Add New Card",
                onTap: () {
                  Get.to(AddCardPage())!.then((_) {
                    // This will run when you come back from AddCardPage
                    controller.fetchUserCards();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesign({required String cardName, required String path}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonText(cardName, size: 14, color: AppColors.white),
          Image.asset(path),
        ],
      ),
    );
  }

  String _getCardImagePath(String cardBrand) {
    switch (cardBrand.toLowerCase()) {
      case 'mastercard':
        return 'assets/images/mastercard.png';
      default:
        return 'assets/images/mastercard.png';
    }
  }
}

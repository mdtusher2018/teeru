import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/add_card.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/congratulations_ticket_punched.dart';
import 'package:trreu/views/res/commonWidgets.dart'; // Make sure this has `commonText`

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Checkout"),

      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Match Card
            Material(
              elevation: 4,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/8/8d/Lutte_s%C3%A9n%C3%A9galaise_Bercy_2013_-_Mame_Balla-Pape_Mor_L%C3%B4_-_32.jpg',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText(
                            "Tyson vs. Tapha Gueye",
                            size: 16,
                            isBold: true,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 14),
                              const SizedBox(width: 4),
                              commonText("08:00 PM    01 Jan 2025"),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14),
                              const SizedBox(width: 4),
                              commonText("Arène National, Pikine"),
                            ],
                          ),
                          const SizedBox(height: 4),
                          commonText(
                            "Seat Info: Section A, Row 2, Seat 12",
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            // Total Price Row
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText("Total Prix", isBold: true, size: 16),
                  commonText(
                    "0 FCFA",
                    isBold: true,
                    size: 16,
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Center(
              child: commonText("Payment Methods", isBold: true, size: 16),
            ),
            const SizedBox(height: 12),

            PaymentButton(
              icon: 'assets/images/Payment-Wave.png',
              label: 'Wave',
            ),
            PaymentButton(
              icon: 'assets/images/Payment-Orange money.png',
              label: 'Orange Money',
            ),
            PaymentButton(
              icon: 'assets/images/Payment-ApplePay.png',
              label: 'Apple Pay',
            ),
            PaymentButton(
              icon: 'assets/images/Payment-GooglePay.png',
              label: 'Google Pay',
            ),
            InkWell(
              onTap: () {
                Get.to(AddCardPage());
              },
              child: PaymentButton(
                icon: 'assets/images/Payment-Add Card.png',
                label: 'Add Card',
              ),
            ),

            const SizedBox(height: 24),
            commonButton(
              "Buy",
              onTap: () {
                Get.to(CongratulationTicketPunchedScreen());
              },
            ),

            const SizedBox(height: 12),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "By continuing, you agree to our ",
                  style: const TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                      text: "Terms of Use",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: "\nAll payments are encrypted and 100% secure.",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String icon;
  final String label;

  const PaymentButton({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(icon),
          const SizedBox(width: 12),
          commonText(label, size: 15),
        ],
      ),
    );
  }
}

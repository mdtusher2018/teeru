// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/checkout_page.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  Map<String, int> quantities = {
    'Tribune': 0,
    'Annexe Loge': 0,
    'Loge VIP': 0,
    'Loge VVIP': 0,
  };

  Map<String, int> prices = {
    'Tribune': 1000,
    'Annexe Loge': 2000,
    'Loge VIP': 3000,
    'Loge VVIP': 25000,
  };

  int get totalPrice {
    int total = 0;
    quantities.forEach((key, qty) {
      total += qty * prices[key]!;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Image and back button
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/8/8d/Lutte_s%C3%A9n%C3%A9galaise_Bercy_2013_-_Mame_Balla-Pape_Mor_L%C3%B4_-_32.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // replace with actual image path
            ),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText("Tyson vs. Tapha Gueye", size: 20, isBold: true),

                // Time & Location
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 6),
                    commonText("08:00 PM", size: 14),
                    const SizedBox(width: 12),
                    commonText("01 Jan 2025", size: 14),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 6),
                    commonText("Arène National, Pikine", size: 14),
                  ],
                ),

                commonText(
                  "Seat Info: Please, see options below",
                  fontWeight: FontWeight.bold,
                  size: 14,
                ),
              ],
            ),

            SizedBox(height: 16),

            // Ticket Options
            ...quantities.entries.map((entry) {
              final name = entry.key;
              final price = prices[name]!;
              final count = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: commonText(name, size: 14, isBold: true)),
                    Expanded(
                      child: commonText(
                        "$price FCFA",
                        size: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              if (quantities[name]! > 0) {
                                setState(
                                  () =>
                                      quantities[name] = quantities[name]! - 1,
                                );
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          commonText(count.toString(), size: 14),
                          InkWell(
                            child: const Icon(
                              Icons.add,
                              color: AppColors.primaryColor,
                            ),
                            onTap: () {
                              setState(
                                () => quantities[name] = quantities[name]! + 1,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(color: AppColors.buttonColor),
            ),
            // Fees
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText("Service Fee", size: 14),
                commonText("0%", size: 14),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText("Processing Fee", size: 14),
                commonText("0%", size: 14),
              ],
            ),

            const SizedBox(height: 10),

            // Total Price
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText(
                    "Total Prix",
                    fontWeight: FontWeight.bold,
                    size: 14,
                  ),
                  commonText(
                    "${totalPrice} FCFA",
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    size: 14,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Confirm Button
            commonButton(
              "Confirm",
              onTap: () {
                Get.to(CheckoutPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/services/local_storage_service.dart';
import 'package:trreu/utils/app_constants.dart';
import 'package:trreu/views/checkout_page.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class TicketDetailsScreen extends StatefulWidget {
  final Event event;

  const TicketDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  late Map<String, int> quantities;
  late Map<String, int> prices;

  @override
  void initState() {
    super.initState();
    prices = {
      'Tribune': widget.event.ticketPrices.tribune.toInt(),
      'Annexe Loge': widget.event.ticketPrices.annexeLoge.toInt(),
      'Loge VIP': widget.event.ticketPrices.logeVIP.toInt(),
      'Loge VVIP': widget.event.ticketPrices.logeVVIP.toInt(),
    };

    quantities = {
      'Tribune': 0,
      'Annexe Loge': 0,
      'Loge VIP': 0,
      'Loge VVIP': 0,
    };
  }

  List<Map<String, dynamic>> get items {
    List<Map<String, dynamic>> result = [];

    quantities.forEach((key, quantity) {
      if (quantity > 0) {
        int unitPrice = prices[key] ?? 0;
        result.add({
          'name': key,
          'quantity': quantity,
          'unit_price': unitPrice,
          'total_price': unitPrice * quantity,
        });
      }
    });

    result.add({
      'name': 'Service Fee',
      'quantity': totalPrice,
      'unit_price': widget.event.ticketPrices.serviceFee / 100,
      "total_price": serviceFeeAmount,
    });
    result.add({
      'name': 'Processing Fee',
      'quantity': totalPrice,
      'unit_price': widget.event.ticketPrices.processingFee / 100,
      "total_price": processingFeeAmount,
    });
    return result;
  }

  int get subtotal {
    int total = 0;
    quantities.forEach((key, qty) {
      total += qty * (prices[key] ?? 0);
    });
    return total;
  }

  int get serviceFeeAmount {
    return ((subtotal * widget.event.ticketPrices.serviceFee) / 100).round();
  }

  int get processingFeeAmount {
    return ((subtotal * widget.event.ticketPrices.processingFee) / 100).round();
  }

  int get totalPrice {
    return subtotal + serviceFeeAmount + processingFeeAmount;
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

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
                    // prepend your base url here if needed
                    getFullImageUrl(event.image),
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
            ),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(event.name, size: 20, isBold: true),

                // Time & Location
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 6),
                    commonText(event.time, size: 14),
                    const SizedBox(width: 12),
                    commonText(
                      "${event.date.day.toString().padLeft(2, '0')}-${event.date.month.toString().padLeft(2, '0')}-${event.date.year}",
                      size: 14,
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 6),
                    Flexible(child: commonText(event.location, size: 14)),
                  ],
                ),

                commonText(
                  "Seat Info: Please, see options below".tr,
                  fontWeight: FontWeight.bold,
                  size: 14,
                ),
              ],
            ),

            SizedBox(height: 16),

            // Ticket Options
            ...quantities.entries.map((entry) {
              final name = entry.key;
              final price = prices[name] ?? 0;
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
                            onTap: () {
                              setState(
                                () => quantities[name] = quantities[name]! + 1,
                              );
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.primaryColor,
                            ),
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
                commonText("Service Fee".tr, size: 14),
                commonText(
                  "${widget.event.ticketPrices.serviceFee} %",
                  size: 14,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText("Processing Fee".tr, size: 14),
                commonText(
                  "${widget.event.ticketPrices.processingFee} %",
                  size: 14,
                ),
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
                    "Total Price".tr,
                    fontWeight: FontWeight.bold,
                    size: 14,
                  ),
                  commonText(
                    "$totalPrice FCFA",
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
              "Confirm".tr,
              onTap: () async {
                LocalStorageService _localService = LocalStorageService();
                String? token = await _localService.getToken();

                if (token == null || token.isEmpty) {
                  commonSnackbar(
                    title: "Not Authorized".tr,
                    message: "Please login to buy Ticket.".tr,
                  );
                  return;
                }

                if (totalPrice > 200) {
                  Get.to(
                    () => CheckoutPage(
                      event: event,
                      amount: totalPrice,
                      quantities: quantities,
                      iteams: items,
                    ),
                  );
                } else {
                  commonSnackbar(
                    title: "Invalid Total Amount",
                    message: "Mimimum amount is 200 FCFA.",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

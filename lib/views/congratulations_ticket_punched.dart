// ignore_for_file: must_be_immutable

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/review_controller.dart';
import 'package:trreu/models/TicketPurchase_model.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class CongratulationTicketPunchedScreen extends StatelessWidget {
  TicketPurchaseData tcketData;
  Event event;
  CongratulationTicketPunchedScreen({
    super.key,
    required this.tcketData,
    required this.event,
  });
  final ReviewController reviewController = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Congratulation!".tr, haveBackButton: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTicketCard(context),
              const SizedBox(height: 30),

              Center(
                child: Column(
                  children: [
                    commonText(
                      'Rate Us'.tr,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      // Update stars based on rating.value
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => InkWell(
                            onTap: () {
                              reviewController.rating.value = index + 1.0;
                            },
                            child: Icon(
                              index < reviewController.rating.value
                                  ? Icons.star
                                  : Icons.star_border,

                              size: 24,
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: commonText(
                        'Tell us about your experience—we’d love to hear from you!'
                            .tr,
                        textAlign: TextAlign.center,
                        size: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: commonTextfield(
                        hintText: 'Type here'.tr,
                        reviewController.commentController,
                        hintcolor: AppColors.white,
                        color: AppColors.buttonColor,
                        maxLine: 4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Obx(
                () => commonButton(
                  reviewController.isLoading.value
                      ? "Submitting...".tr
                      : "Submit".tr,
                  onTap:
                      reviewController.isLoading.value
                          ? null
                          : () {
                            reviewController.submitReview();
                          },
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    final eventDate = tcketData.createdAt;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText(
            "${eventDate.day}/${eventDate.month}/${eventDate.year} • ${eventDate.hour}h",
            size: 14,
            color: AppColors.white,
          ),
          const SizedBox(height: 6),
          commonText(
            event.name,
            size: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white70,
                size: 16,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: commonText(
                  event.location,
                  size: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                BarcodeWidget(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  data:
                      'ticket data'
                          .tr, // You can use any ticket ID or code here
                  barcode: Barcode.code128(),
                  width: double.infinity,
                  height: 90,
                  drawText: false,
                ),
                const SizedBox(height: 8),
                commonText(
                  "A screenshot of your ticket will not be accepted".tr,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Ticket Type Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    "Ticket Type".tr,
                    size: 12,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 4),
                  ...tcketData.tickets.map((ticket) {
                    final parts = ticket.type.split(' ');
                    final ticketType = parts.isNotEmpty ? parts[0] : "N/A";
                    return commonText(
                      ticketType,
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    );
                  }).toList(),
                ],
              ),

              // Seat Number Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    "Seat Number".tr,
                    size: 12,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 4),
                  ...tcketData.tickets.map((ticket) {
                    final parts = ticket.type.split(' ');
                    final seat = parts.length > 1 ? parts[1] : "N/A";
                    return commonText(
                      seat,
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}

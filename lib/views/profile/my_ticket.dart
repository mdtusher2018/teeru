// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/MyTicketsController.dart';
import 'package:trreu/controllers/review_controller.dart';
import 'package:trreu/utils/app_constants.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/profile/view_ticket.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class MyTicketsScreen extends StatelessWidget {
  MyTicketsScreen({Key? key}) : super(key: key);

  final ReviewController reviewController = Get.put(ReviewController());
  final MyTicketsController myTicketsController = Get.put(
    MyTicketsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: commonAppBar(
        "My Tickets",
        color: AppColors.primaryColor,
        textcolor: AppColors.white,
      ),

      body: Obx(() {
        if (myTicketsController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.white),
          );
        }

        if (myTicketsController.tickets.isEmpty) {
          return Center(
            child: commonText(
              "No tickets found.",
              color: Colors.white,
              size: 16,
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...myTicketsController.tickets.map((ticket) {
                final event = ticket.event;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildTicketCard(
                    context,
                    image: getFullImageUrl(
                      event.category.image,
                    ), // Adjust URL as needed
                    title: event.name,
                    seat: ticket.tickets
                        .where((e) => e.seat > 0) // only seats > 0
                        .map((e) => '${e.type}: ${e.seat}')
                        .join(', '),
                    date: event.date.toLocal().toString().split(' ')[0],
                    time: event.time,
                    onTap: () {
                      Get.to(() => ViewTicketScreen(ticket: ticket));
                    },
                  ),
                );
              }).toList(),

              const SizedBox(height: 30),

              // Rating Section below...
              Center(
                child: Column(
                  children: [
                    commonText(
                      'Rate Us',
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                              color: Colors.white,
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
                        'Tell us about your experience—we’d love to hear from you!',
                        textAlign: TextAlign.center,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: commonTextfield(
                        hintText: 'Type here',
                        reviewController.commentController,
                        hintcolor: AppColors.white,
                        color: AppColors.buttonColor,
                        maxLine: 4,
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(
                      () => commonButton(
                        reviewController.isLoading.value
                            ? "Submitting..."
                            : "Submit",
                        onTap:
                            reviewController.isLoading.value
                                ? null
                                : () {
                                  reviewController.submitReview();
                                },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTicketCard(
    BuildContext context, {
    required String image,
    required String title,
    required String seat,
    required String date,
    required String time,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Image.network(
              image,
              height: 100,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(
                  title,
                  maxLine: 1,
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

                commonText('$time    $date', size: 12, color: Colors.white70),

                commonText(
                  'Seat Info: $seat',
                  size: 12,
                  color: Colors.white,
                  isBold: true,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 35,
                  child: Center(
                    child: commonButton(
                      "View Ticket",
                      color: AppColors.white,
                      textColor: AppColors.black,
                      width: 100,
                      textSize: 12,
                      onTap: onTap,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

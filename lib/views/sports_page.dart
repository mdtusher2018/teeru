import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/SportsController.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:trreu/views/ticket_details.dart';

class SportsPage extends StatelessWidget {
  final String categoryId; // Pass category id here
  final String categoryName;
  final String categoryImage;

  SportsPage({Key? key, required this.categoryId, required this.categoryName,required this.categoryImage})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SportsController controller = Get.put(SportsController(categoryId,recivedCategoryImage: categoryImage));

    Widget EventCard(Event event) {
      log(event.name);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(TicketDetailsScreen(event: event))!.then((value) {
                    controller.fetchEvents();
                  });
                },
                child: commonText(
                  "Buy".tr,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(event.name, fontWeight: FontWeight.bold),
                  SizedBox(height: 4),
                  commonText(event.date.toString(), color: Colors.grey[700]!),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Expanded(
                        child: commonText(
                          event.location,
                          color: Colors.grey[700]!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return (controller.categoryImage.value.isEmpty)
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                    height: 220,
                    padding: const EdgeInsets.all(24.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(controller.categoryImage.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,

                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
            }),
            SizedBox(height: 16),
            commonText(categoryName, size: 18, fontWeight: FontWeight.bold),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    if (!controller.isLoading.value)
                      Divider(color: AppColors.black),
                    (controller.isLoading.value)
                        ? Center(child: CircularProgressIndicator())
                        : (controller.events.isEmpty)
                        ? Center(
                          child: commonText(
                            "No events available".tr,
                            size: 21,
                            isBold: true,
                          ),
                        )
                        : ListView.separated(
                          padding: EdgeInsets.all(8),
                          itemCount: controller.events.length,
                          separatorBuilder:
                              (context, index) =>
                                  Divider(color: AppColors.black),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final event = controller.events[index];
                            return EventCard(event);
                          },
                        ),

                    if (!controller.isLoading.value)
                      Divider(color: AppColors.black),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

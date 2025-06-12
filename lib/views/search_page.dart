// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/all_event_controller.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/utils/app_constants.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:trreu/views/ticket_details.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController searchController = TextEditingController();
  final AllEventsController controller = Get.put(AllEventsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: commonTextfield(
                    height: 40.0,
                    enable: true,
                    searchController,
                    prefixIcon: Icon(Icons.search),
                    onChanged: (value) => controller.searchEvents(value),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.cancel),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final event = controller.searchResults[index];
                    return upcomingCard(event);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget upcomingCard(Event event) {
    return InkWell(
      onTap: () {
        Get.to(
          () => TicketDetailsScreen(event: event),
        ); // pass event id if needed
      },
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(getFullImageUrl(event.image)),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.bottomLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    commonText(
                      event.name,
                      size: 16,
                      isBold: true,
                      color: AppColors.white,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 4),
                          commonText(event.location, color: AppColors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    commonText(event.headToHead, color: AppColors.white),
                    commonText(
                      "${event.time}  ${event.date.toLocal().toString().split(' ')[0]}",
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

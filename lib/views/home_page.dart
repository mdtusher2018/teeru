import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:trreu/controllers/home_controller.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/utils/app_constants.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/profile/contact_page.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:trreu/views/search_page.dart';
import 'package:trreu/views/sports_page.dart';
import 'package:trreu/views/ticket_details.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: SizedBox(),
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                commonText("Thies, SN", size: 14),
              ],
            ),
            const CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage(
                'assets/images/france.png',
              ), // French flag icon
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: 100),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Get.to(SearchPage());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: commonTextfield(
                    hintText: "Teams, Artists, Concerts on Teeru",
                    enable: false,
                    TextEditingController(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(ContactUsScreen());
                      },
                      child: commonText("Contact Us", isBold: true),
                    ),
                  ],
                ),
              ),
              // Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 140,
                  child: Obx(() {
                    if (controller.isLoadingCategories.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: controller.categories.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                SportsPage(
                                  categoryId: category.id,
                                  categoryName: category.name,
                                ),
                              );
                            },
                            child: categoryCard(
                              category.name,
                              getFullImageUrl(category.image),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),

              // Infinite Scroll Banner
              Container(
                height: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Marquee(
                  text: 'Follow sur Instragram @TeeruApp.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 50.0,
                  pauseAfterRound: Duration(seconds: 0),
                  startPadding: 10.0,

                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration.zero,
                  decelerationCurve: Curves.linear,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    commonText("Upcoming Events", size: 16, isBold: true),
                  ],
                ),
              ),

              // ListView.separated(
              //   separatorBuilder: (context, index) {
              //     return SizedBox(height: 16);
              //   },
              //   itemCount: 4,
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 16,
              //         vertical: 8,
              //       ),
              //       child: upcomingCard(),
              //     );
              //   },
              // ),
              Obx(() {
                log(
                  "........................${controller.upcomingEvents.length}",
                );
                return ListView.separated(
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  itemCount: controller.upcomingEvents.length, // dynamic count
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final event =
                        controller.upcomingEvents[index]; // get event at index
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: upcomingCard(event), // pass event data to widget
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// 📦 Category Card
  Widget categoryCard(String title, String imagePath) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [commonText(title, color: Colors.white, isBold: true)],
          ),
        ],
      ),
    );
  }

  Widget upcomingCard(Event event) {
    return InkWell(
      onTap: () {
        Get.to(() => TicketDetailsScreen()); // pass event id if needed
      },
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(
              getFullImageUrl(event.category.image),
              // "https://c7.alamy.com/comp/BX8G0R/he-italy-u-20-national-team-lines-up-prior-to-the-start-of-a-fifa-BX8G0R.jpg",
            ),
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
                    commonText("Time: ${event.time}", color: AppColors.white),
                    commonText(
                      "Date: ${event.date.toLocal().toString().split(' ')[0]}",
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

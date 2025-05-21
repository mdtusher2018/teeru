import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/profile/contact_page.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:trreu/views/search_page.dart';
import 'package:trreu/views/sports_page.dart';
import 'package:trreu/views/ticket_details.dart';

class HomePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  HomePage({super.key});

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
                    searchController,
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
              // Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 140,

                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            Get.to(SportsPage());
                          },
                          child: categoryCard(
                            'Football',
                            'https://upload.wikimedia.org/wikipedia/commons/8/8d/Lutte_s%C3%A9n%C3%A9galaise_Bercy_2013_-_Mame_Balla-Pape_Mor_L%C3%B4_-_32.jpg',
                          ),
                        ),
                      );
                    },
                  ),
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
              ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: upcomingCard(),
                  );
                },
              ),
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

  Widget upcomingCard() {
    return InkWell(
      onTap: () {
        Get.to(TicketDetailsScreen());
      },
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: NetworkImage(
              "https://c7.alamy.com/comp/BX8G0R/the-italy-u-20-national-team-lines-up-prior-to-the-start-of-a-fifa-BX8G0R.jpg",
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
                      "Men’s Football",
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
                          SizedBox(width: 4),
                          commonText(
                            "Diamniadio Olympic Stadium",
                            color: AppColors.white,
                          ),
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
                    commonText("Senegal vs. Morocco", color: AppColors.white),
                    commonText("18:45   23 Nov 2024", color: AppColors.white),
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

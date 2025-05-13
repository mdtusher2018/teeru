import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';
import 'package:trreu/ticket_details.dart';

class SportsPage extends StatelessWidget {
  final List<Map<String, String>> events = [
    {
      'title': 'US Ouakam vs. Jaraff',
      'date': 'Feb. 1st   14:30',
      'location': 'Stade Lat Dior',
    },
    {
      'title': 'Dakar Sacré Coeur vs. Oslo FA',
      'date': 'Feb. 1st   14:30',
      'location': 'Stade Municipal de Ngor',
    },
    {
      'title': 'Senegal vs. Algérie (M)',
      'date': 'Feb. 6th   17:00',
      'location': 'Stade Abdoulaye Wade',
    },
    {
      'title': 'Senegal vs. Bénin (W)',
      'date': 'Feb. 7th   18:00',
      'location': 'Stade Abdoulaye Wade',
    },
    {
      'title': 'Guédiawaye FC vs. Wallydaan',
      'date': 'Feb. 10th   15:00',
      'location': 'Stade Amadou Barry',
    },
    {
      'title': 'US Gorée vs. ASC La Linguère',
      'date': 'Feb. 11th   15:30',
      'location': 'Stade Aline Sitoé Diatta',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/8/8d/Lutte_s%C3%A9n%C3%A9galaise_Bercy_2013_-_Mame_Balla-Pape_Mor_L%C3%B4_-_32.jpg',
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
            SizedBox(height: 16),
            commonText(
              "Football Events",
              size: 18,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Divider(color: AppColors.black),
                  ListView.separated(
                    itemCount: 4,
                    separatorBuilder: (context, index) {
                      return Divider(color: AppColors.black);
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return EventCard(events[index]);
                    },
                  ),
                  Divider(color: AppColors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget EventCard(Map<String, String> event) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                Get.to(TicketDetailsScreen());
              },
              child: commonText(
                "Buy",
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
                commonText(event['title'] ?? '', fontWeight: FontWeight.bold),
                SizedBox(height: 4),
                commonText(event['date'] ?? '', color: Colors.grey[700]!),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.green),
                    SizedBox(width: 4),
                    Expanded(
                      child: commonText(
                        event['location'] ?? '',
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
}

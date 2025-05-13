// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/profile/view_ticket.dart';
import 'package:trreu/res/commonWidgets.dart';

class MyTicketsScreen extends StatelessWidget {
  MyTicketsScreen({Key? key}) : super(key: key);

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: commonAppBar(
        "My Tickets",
        color: AppColors.primaryColor,
        textcolor: AppColors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTicketCard(
              context,
              image:
                  'https://upload.wikimedia.org/wikipedia/commons/8/8d/Lutte_s%C3%A9n%C3%A9galaise_Bercy_2013_-_Mame_Balla-Pape_Mor_L%C3%B4_-_32.jpg',
              title: 'Lamb Game',
              seat: 'Loge VVIP',
              date: '23 Nov 2024',
              time: '08:00 PM',
            ),
            const SizedBox(height: 12),
            _buildTicketCard(
              context,
              image:
                  'https://upload.wikimedia.org/wikipedia/commons/8/8d/Lutte_s%C3%A9n%C3%A9galaise_Bercy_2013_-_Mame_Balla-Pape_Mor_L%C3%B4_-_32.jpg',
              title: 'Men\'s Basketball',
              seat: 'Tribune',
              date: '23 Nov 2024',
              time: '08:00 PM',
            ),
            const SizedBox(height: 30),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star_border,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
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
                      commentController,
                      hintcolor: AppColors.white,
                      color: AppColors.buttonColor,
                      maxLine: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCard(
    BuildContext context, {
    required String image,
    required String title,
    required String seat,
    required String date,
    required String time,
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
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

                commonText('$time    $date', size: 12, color: Colors.white70),

                commonText('Seat Info: $seat', size: 12, color: Colors.white70),
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
                      onTap: () {
                        Get.to(ViewTicketScreen());
                      },
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

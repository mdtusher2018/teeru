// ignore_for_file: must_be_immutable

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class CongratulationTicketPunchedScreen extends StatelessWidget {
  CongratulationTicketPunchedScreen({super.key});

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Congratulation!", haveBackButton: false),
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
                      'Rate Us',
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => const Icon(Icons.star_border, size: 24),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: commonText(
                        'Tell us about your experience—we’d love to hear from you!',
                        textAlign: TextAlign.center,
                        size: 14,
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

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText("Wed, Jan 1 • 20h", size: 14, color: AppColors.white),
          const SizedBox(height: 6),
          commonText(
            "Tyson vs. Tapha Gueye",
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
                  "Arène National, Pikine",
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
                  data: 'ticket data', // You can use any ticket ID or code here
                  barcode: Barcode.code128(),
                  width: double.infinity,
                  height: 90,
                  drawText: false,
                ),
                const SizedBox(height: 8),
                commonText(
                  "A screenshot of your ticket will not be accepted",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Ticket Type", size: 12, color: AppColors.white),
                  const SizedBox(height: 4),
                  commonText(
                    "Loge",
                    size: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("SEATING LEVEL", size: 12, color: AppColors.white),
                  const SizedBox(height: 4),
                  commonText(
                    "VVIP",
                    size: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
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

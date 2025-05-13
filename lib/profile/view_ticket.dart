import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';

class ViewTicketScreen extends StatelessWidget {
  const ViewTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("View Tickets"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTicketCard(context),
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/full_logo.png', // Make sure this matches your asset path
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

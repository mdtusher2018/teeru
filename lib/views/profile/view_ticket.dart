import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:trreu/models/user_tickets_model.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class ViewTicketScreen extends StatelessWidget {
  final UserTicket ticket;

  const ViewTicketScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("View Tickets"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTicketCard(context, ticket),
              const SizedBox(height: 30),
              Image.asset('assets/images/full_logo.png'),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, UserTicket ticket) {
    final event = ticket.event;
    String formattedDate = event.date.toLocal().toString().split(' ')[0];

    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText(
            "$formattedDate • ${event.time}",
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
                  data: ticket.id,
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
              commonText(
                "Ticket Type",
                size: 14,
                color: AppColors.white,
                isBold: true,
              ),
              commonText(
                "SEAT",
                size: 14,
                color: AppColors.white,
                isBold: true,
              ),
            ],
          ),
          ...ticket.tickets.map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(
                  e.type, // dynamically from your ticket object
                  size: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                commonText(
                  seatingLevelLabel(
                    e.seat.toString(),
                  ), // function to map type to label
                  size: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ],
            );
          }),

          SizedBox(height: 80),
        ],
      ),
    );
  }

  String seatingLevelLabel(String ticketType) {
    switch (ticketType.toLowerCase()) {
      case 'tribune':
        return 'Tribune';
      case 'annexe loge':
        return 'Annexe Loge';
      case 'loge vip':
        return 'VIP';
      case 'loge vvip':
        return 'VVIP';
      default:
        return ticketType; // fallback to the same name
    }
  }
}

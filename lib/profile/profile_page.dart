import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/auth/login_page.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/profile/contact_page.dart';
import 'package:trreu/profile/edit_profile.dart';
import 'package:trreu/profile/my_ticket.dart';
import 'package:trreu/profile/payment_methods.dart';
import 'package:trreu/profile/redeem.dart';
import 'package:trreu/res/commonWidgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText("My Teeru's Account", size: 18, isBold: true),
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture and Name
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://assets.turfonline.co.uk/2019/04/sedum-groundcover-816x288.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 70),
                        CircleAvatar(
                          radius: 53,
                          backgroundColor: AppColors.primaryColor,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              'https://www.earth.com/assets/_next/image/?url=https%3A%2F%2Fcff2.earth.com%2Fuploads%2F2023%2F08%2F26042949%2FNational-Dog-Day--1400x850.jpg&w=1200&q=75',
                            ), // Add your image here
                          ),
                        ),
                        SizedBox(height: 10),
                        commonText("Zinho Pi’erre", size: 16, isBold: true),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Menu Items
              Column(
                children: [
                  _buildMenuItem(
                    "assets/icons/profile.png",
                    "Manage Profile",
                    () {
                      Get.to(EditProfileScreen());
                    },
                  ),
                  _buildMenuItem(
                    "assets/icons/payment.png",
                    "Payment Method",
                    () {
                      Get.to(PaymentOptionScreen());
                    },
                  ),
                  _buildMenuItem(
                    "assets/icons/giftcard.png",
                    "Redeem Code",
                    () {
                      Get.to(RedeemCodeScreen());
                    },
                  ),
                  _buildMenuItem(
                    "assets/icons/mytecaket.png",
                    "My Tickets/Rate Us",
                    () {
                      Get.to(MyTicketsScreen());
                    },
                  ),
                  _buildMenuItem("assets/icons/contact.png", "Contact Us", () {
                    Get.to(ContactUsScreen());
                  }),
                ],
              ),
              SizedBox(height: 20),

              // Sign Out Button
              commonButton(
                "Sign Out",
                onTap: () {
                  Get.to(LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build menu items
  Widget _buildMenuItem(String icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Image.asset(icon, color: AppColors.primaryColor),
      title: commonText(title, size: 16),
      trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
      onTap: onTap,
    );
  }
}

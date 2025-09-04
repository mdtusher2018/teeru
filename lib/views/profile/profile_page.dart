import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/profile_controller.dart';
import 'package:trreu/services/local_storage_service.dart';
import 'package:trreu/utils/app_constants.dart';
import 'package:trreu/views/auth/login_page.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/profile/contact_page.dart';
import 'package:trreu/views/profile/edit_profile.dart';
import 'package:trreu/views/profile/my_ticket.dart';
import 'package:trreu/views/profile/payment_methods.dart';
import 'package:trreu/views/profile/redeem.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    final ProfileController controller = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText("My Teeru's Account".tr, size: 18, isBold: true),
        leading: SizedBox(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.userProfile.value;

        if (user == null) {
          return Center(
            child: Column(
              children: [
                Center(
                  child: commonText(
                    "Failed to load profile".tr,
                    size: 21,
                    isBold: true,
                    color: AppColors.buttonColor,
                  ),
                ),
                commonButton(
                  "Go to Login".tr,
                  onTap: () {
                    Get.offAll(LoginScreen());
                  },
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
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
                          image:
                              user.coverImage.isNotEmpty
                                  ? NetworkImage(
                                    getFullImageUrl(user.coverImage),
                                  )
                                  : const NetworkImage(
                                        "https://assets.turfonline.co.uk/2019/04/sedum-groundcover-816x288.jpg",
                                      )
                                      as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 70),
                          CircleAvatar(
                            radius: 53,
                            backgroundColor: AppColors.buttonColor,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  user.profileImage.isNotEmpty
                                      ? NetworkImage(
                                        getFullImageUrl(user.profileImage),
                                      )
                                      : const NetworkImage(
                                            "https://www.earth.com/assets/_next/image/?url=https%3A%2F%2Fcff2.earth.com%2Fuploads%2F2023%2F08%2F26042949%2FNational-Dog-Day--1400x850.jpg&w=1200&q=75",
                                          )
                                          as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 10),
                          commonText(user.fullName, size: 16, isBold: true),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Menu Items
                Column(
                  children: [
                    _buildMenuItem(
                      "assets/icons/profile.png",
                      "Manage Profile".tr,
                      () => Get.to(EditProfileScreen())!.then((value) {
                        controller.fetchProfile();
                      }),
                    ),
                    _buildMenuItem(
                      "assets/icons/payment.png",
                      "Payment Method".tr,
                      () => Get.to(PaymentMethordScreen()),
                    ),
                    _buildMenuItem(
                      "assets/icons/giftcard.png",
                      "Redeem Code".tr,
                      () => Get.to(RedeemCodeScreen()),
                    ),
                    _buildMenuItem(
                      "assets/icons/mytecaket.png",
                      "My Tickets/Rate Us".tr,
                      () => Get.to(MyTicketsScreen()),
                    ),
                    _buildMenuItem(
                      "assets/icons/contact.png",
                      "Contact Us".tr,
                      () => Get.to(ContactUsScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Sign Out Button
                commonButton(
                  "Sign Out".tr,
                  onTap: () {
                    LocalStorageService _localStorageService =
                        LocalStorageService();
                    _localStorageService.removeToken();
                    _localStorageService.removeRememberMeToken();
                    _localStorageService.clearAll();
                    Get.offAll(LoginScreen());
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMenuItem(String icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Image.asset(icon, color: AppColors.buttonColor),
      title: commonText(title, size: 16),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}

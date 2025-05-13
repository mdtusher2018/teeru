import 'package:flutter/material.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({super.key});

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        "Edit Profile",
        color: AppColors.primaryColor,
        textcolor: AppColors.white,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.all(16),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 70),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 24.0,
                                right: 24,
                              ),
                              child: CircleAvatar(
                                radius: 53,
                                backgroundColor: AppColors.yellow,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    'https://www.earth.com/assets/_next/image/?url=https%3A%2F%2Fcff2.earth.com%2Fuploads%2F2023%2F08%2F26042949%2FNational-Dog-Day--1400x850.jpg&w=1200&q=75',
                                  ), // Add your image here
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 24,
                              right: 20,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.yellow,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                        commonText("Zinho Pi’erre", size: 16, isBold: true),
                        SizedBox(height: 20),
                        // Full Name TextField
                        commonTextfield(
                          _fullNameController,
                          hintText: 'Enter Full Name',
                          textSize: 14.0,
                          prefixIcon: Icon(Icons.person_2_outlined),
                          isPasswordVisible: false,
                          enable: true,
                        ),
                        SizedBox(height: 8),

                        // Email TextField
                        commonTextfield(
                          _emailController,
                          hintText: 'Enter Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                          textSize: 14.0,
                          isPasswordVisible: false,
                          enable: true,
                        ),
                        SizedBox(height: 8),

                        // Phone Number TextField
                        commonTextfield(
                          _phoneNumberController,
                          hintText: 'Enter Phone Number',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 8),
                            child: commonText("+221", size: 16),
                          ),
                          textSize: 14.0,

                          isPasswordVisible: false,
                          enable: true,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 8),
                        commonTextfield(
                          hintText: "Location",
                          _locationController,
                        ),

                        SizedBox(height: 24),
                        commonButton("Save Changes"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

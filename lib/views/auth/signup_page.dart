import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/controllers/signup_controller.dart';
import 'package:trreu/views/auth/login_page.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignUpController controller = Get.put(SignUpController());

  Widget _genderButton(String gender) {
    return Obx(() {
      bool isSelected = controller.selectedGender.value == gender;
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.setGender(gender),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.buttonColor : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.buttonColor, width: 1),
            ),
            child: Center(
              child: commonText(
                gender,
                color: isSelected ? Colors.white : Colors.black,
                size: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: commonText("Sign Up", size: 21, isBold: true)),
              const SizedBox(height: 10),
              commonText(
                'Let\'s get started',
                size: 14,
                isBold: true,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              commonTextfield(
                controller.fullNameController,
                hintText: 'Enter Full Name',
                textSize: 14,
                prefixIcon: const Icon(Icons.person_2_outlined),
                enable: true,

                // Optionally add error binding here
              ),
              const SizedBox(height: 24),

              commonTextfield(
                controller.emailController,
                hintText: 'Enter Email Address',
                prefixIcon: const Icon(Icons.email_outlined),
                textSize: 14,
                enable: true,
              ),
              const SizedBox(height: 24),

              commonTextfield(
                controller.phoneNumberController,
                hintText: 'Enter Phone Number',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 8),
                  child: commonText("+221", size: 16),
                ),
                textSize: 14,
                enable: true,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              Obx(
                () => commonTextfield(
                  controller.passwordController,
                  hintText: 'Create Password',
                  textSize: 14,
                  isPasswordVisible: controller.isPasswordVisible.value,
                  issuffixIconVisible: true,
                  changePasswordVisibility: () {
                    controller.isPasswordVisible.value =
                        !controller.isPasswordVisible.value;
                  },
                  enable: true,
                ),
              ),
              const SizedBox(height: 24),

              Obx(
                () => commonTextfield(
                  controller.confirmPasswordController,
                  hintText: 'Confirm Password',
                  textSize: 14,
                  isPasswordVisible: controller.isConfirmPasswordVisible.value,
                  issuffixIconVisible: true,
                  changePasswordVisibility: () {
                    controller.isConfirmPasswordVisible.value =
                        !controller.isConfirmPasswordVisible.value;
                  },
                  enable: true,
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _genderButton('Male'),
                  const SizedBox(width: 50),
                  _genderButton('Female'),
                ],
              ),

              const SizedBox(height: 24),

              Obx(
                () => commonButton(
                  controller.isLoading.value ? 'Creating...' : 'Create Account',
                  onTap:
                      controller.isLoading.value
                          ? null
                          : () => controller.signUp(),
                  textSize: 18,
                  color: AppColors.buttonColor,
                  textColor: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  commonText('Already have a Teeru account? ', size: 14),
                  GestureDetector(
                    onTap: () => Get.to(() => LoginScreen()),
                    child: commonText(
                      'Log In',
                      isBold: true,
                      size: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  commonText(
                    'Cancel',
                    size: 14,
                    color: AppColors.primaryColor,
                    isBold: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

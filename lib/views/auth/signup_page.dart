import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/auth/login_page.dart';
import 'package:trreu/views/auth/signup_splash.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/res/commonWidgets.dart'; // Import your AppColors file for styling

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _selectedGender = 'Male'; // Default Gender

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _signUp() {
    Get.to(SignUpSplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: commonText("Sign Up", size: 21, isBold: true)),
              SizedBox(height: 10),
              // Title Text
              commonText(
                'Let\'s get started',
                size: 14.0,
                isBold: true,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24),

              // Full Name TextField
              commonTextfield(
                _fullNameController,
                hintText: 'Enter Full Name',
                textSize: 14.0,
                prefixIcon: Icon(Icons.person_2_outlined),
                isPasswordVisible: false,
                enable: true,
              ),
              SizedBox(height: 24),

              // Email TextField
              commonTextfield(
                _emailController,
                hintText: 'Enter Email Address',
                prefixIcon: Icon(Icons.email_outlined),
                textSize: 14.0,
                isPasswordVisible: false,
                enable: true,
              ),
              SizedBox(height: 24),

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
              SizedBox(height: 24),

              // Password TextField
              commonTextfield(
                _passwordController,
                hintText: 'Create Password',
                textSize: 14.0,
                isPasswordVisible: _isPasswordVisible,
                enable: true,
                issuffixIconVisible: true,
                changePasswordVisibility: _togglePasswordVisibility,
              ),
              SizedBox(height: 24),

              // Confirm Password TextField
              commonTextfield(
                _confirmPasswordController,
                hintText: 'Confirm Password',
                textSize: 14.0,
                isPasswordVisible: _isConfirmPasswordVisible,
                enable: true,
                issuffixIconVisible: true,
                changePasswordVisibility: _toggleConfirmPasswordVisibility,
              ),
              SizedBox(height: 24),

              // Gender Selection (Radio buttons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Male button
                  _genderButton('Male'),
                  SizedBox(width: 50),
                  // Female button
                  _genderButton('Female'),
                ],
              ),

              SizedBox(height: 24),

              // Sign Up Button

              // Terms and Conditions Text
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By creating a Teeru’s account, you agree to our ",

                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Terms of Services",
                      style: TextStyle(color: AppColors.primaryColor),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the Terms of Services link tap
                              print("Terms of Services tapped");
                            },
                    ),
                    TextSpan(
                      text: " and ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(color: AppColors.primaryColor),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the Privacy Policy link tap
                              print("Privacy Policy tapped");
                            },
                    ),
                    TextSpan(text: ". Dalal Ak Jàmm!"),
                  ],
                ),
              ),

              SizedBox(height: 24),
              commonButton(
                'Create Account',

                onTap: _signUp,
                textSize: 18.0,
                color: AppColors.buttonColor,
                textColor: Colors.white,
              ),

              SizedBox(height: 24),
              // Login link
              Row(
                children: [
                  commonText('Already have a Teeru account? ', size: 14.0),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: commonText(
                      'Log In',
                      isBold: true,
                      size: 14.0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Spacer(),
                  commonText(
                    "Cancel",
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

  Widget _genderButton(String gender) {
    bool isSelected = _selectedGender == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = gender;
          });
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.buttonColor : AppColors.white,
            borderRadius: BorderRadius.circular(10.0),
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
  }
}

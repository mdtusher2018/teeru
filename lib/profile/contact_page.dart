import 'package:flutter/material.dart';
import 'package:trreu/colors.dart';
import 'package:trreu/res/commonWidgets.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonText("Contact Us", size: 16, isBold: true),
              SizedBox(height: 8),
              Row(children: [commonText('Need Help?', size: 18, isBold: true)]),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: commonText(
                  'If you have questions, feedback, or need support using Teeru, we’re here for you.\nFeel free to reach out anytime—we’d love to hear from you.',
                  size: 14,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Open email client for support email
                  _launchEmail('support@teerun.com');
                },
                child: commonText(
                  '📩 support@teerun.com',
                  color: AppColors.primaryColor,
                  isBold: true,
                  size: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Divider(
                  color: AppColors.primaryColor,
                  thickness: 2,
                  height: 30,
                ),
              ),

              // Partner With Teeru Section
              Row(
                children: [
                  commonText('Partner With Teeru', size: 18, isBold: true),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: commonText(
                  'Interested in marketing collaborations or partnerships?',
                  textAlign: TextAlign.center,
                  size: 14,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Open email client for contact email
                  _launchEmail('contact@teerun.com');
                },
                child: commonText(
                  '📩 contact@teerun.com',
                  color: AppColors.primaryColor,
                  size: 14,
                  isBold: true,
                ),
              ),

              SizedBox(height: 20),
              Image.asset("assets/images/full_logo.png"),
            ],
          ),
        ),
      ),
    );
  }

  // Function to open the email client with the given email
  void _launchEmail(String email) {
    // You can use a package like 'url_launcher' to open the email client
    // final Uri emailUri = Uri(scheme: 'mailto', path: email);
    // launch(emailUri.toString());
  }
}

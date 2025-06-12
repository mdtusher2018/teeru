import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/profile/profile_page.dart';
import 'package:trreu/views/ticket.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  static int currentIndex = 2;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<Widget> _pages = [
    HomePage(), // Your existing home screen
    TicketScreen(), // Placeholder for tickets
    ProfileScreen(), // Placeholder for profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[RootPage.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: RootPage.currentIndex,
        backgroundColor: AppColors.buttonColor,
        onTap: (index) => setState(() => RootPage.currentIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade700,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigation/home.png",
              color: (RootPage.currentIndex == 0) ? Colors.white : Colors.grey,
            ),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigation/Ticket.png",
              color: (RootPage.currentIndex == 1) ? Colors.white : Colors.grey,
            ),
            label: 'Tickets'.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigation/Profile.png",
              color: (RootPage.currentIndex == 2) ? Colors.white : Colors.grey,
            ),
            label: 'Profile'.tr,
          ),
        ],
      ),
    );
  }
}

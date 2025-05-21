import 'package:flutter/material.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/profile/profile_page.dart';
import 'package:trreu/views/ticket.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    HomePage(), // Your existing home screen
    TicketScreen(), // Placeholder for tickets
    ProfileScreen(), // Placeholder for profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.buttonColor,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade700,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigation/home.png",
              color: (_currentIndex == 0) ? Colors.white : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigation/Ticket.png",
              color: (_currentIndex == 1) ? Colors.white : Colors.grey,
            ),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigation/Profile.png",
              color: (_currentIndex == 2) ? Colors.white : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
